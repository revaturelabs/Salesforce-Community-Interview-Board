public with sharing class CreateMeetingApexCont {
    
    @AuraEnabled
    public static List<List<sObject>> getAll()
    {
        //get clients, associates, and batches for the picklists
        List<List<sObject>> objs = new List<List<sObject>>();
        objs.add(getClients());
        objs.add(getAssociates());
        objs.add(getBatches());
        return objs;
    }

    @AuraEnabled
    public static List<Account> getBatches()
    {
        //try to get  a list of batches, if nothing's there, return empty list
        try {
            return [SELECT Id, Name FROM Account WHERE RecordType.Name = 'Batch'];
        } catch(Exception e) {
            return new List<Account>();
        }
    }

    @AuraEnabled
    public static List<Contact> getAssociates()
    {
        //try to get  a list of associates, if nothing's there, return empty list
        try {
            return [SELECT Id, Name, AccountId FROM Contact WHERE RecordType.Name = 'Associate'];
        } catch(Exception e) {
            return new List<Contact>();
        }
    }

    @AuraEnabled
    public static List<Contact> getClients()
    {
        //try to get  a list of clients, if nothing's there, return empty list
        try {
            return [SELECT Id, Name, AccountId FROM Contact WHERE RecordType.Name = 'Client'];
        } catch(Exception e) {
            return new List<Contact>();
        }
    }


    @AuraEnabled
    public static Meeting__c createMeeting(Meeting__c meeting, Account batch, Contact interviewer, Contact associate)
    {
        insert meeting;
        //Queries all individual associates in a batch
        Contact[] fullBatch = [SELECT Id FROM Contact WHERE AccountId =: batch.Id];

        List<Meeting_Participant__c> meetingParticipants = new List<Meeting_Participant__c>();

        //Adds the interviewer to the meeting
        meetingParticipants.add(new Meeting_Participant__c(Participant__c = interviewer.Id, Meeting__c = meeting.Id));

        //if an associate was selected, only that associate will be added to the meeting
        if(associate!=null)                  
           meetingParticipants.add(new Meeting_Participant__c(Participant__c = associate.Id, Meeting__c = meeting.Id));

        //if no associate was selected, the entire batch will be added to the meeting
        else {

            for(Contact c : fullBatch)
            {
                meetingParticipants.add(new Meeting_Participant__c(Participant__c = c.Id, Meeting__c = meeting.Id));
            }
        }

        insert meetingParticipants;
        return meeting;
    }
}