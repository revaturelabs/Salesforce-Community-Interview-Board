public with sharing class CreateMeetingApexCont {
    
    @AuraEnabled
    public static List<List<sObject>> getAll()
    {
        //get clients, associates, and batches for the picklists
        //put a list of each object into a list, return that
        //to js
        List<List<sObject>> objs = new List<List<sObject>>();
        objs.add(getClients());
        objs.add(getAssociates());
        objs.add(getBatches());
        return objs;
    }

    @AuraEnabled
    public static List<Account> getBatches()
    {
        // get  a list of batches, if nothing's there, return empty list
        return [SELECT Id, Name FROM Account WHERE RecordType.Name = 'Batch'];
    }

    @AuraEnabled
    public static List<Contact> getAssociates()
    {
        // get  a list of associates, if nothing's there, return empty list
        return [SELECT Id, Name, AccountId FROM Contact WHERE RecordType.Name = 'Associate'];
    }

    @AuraEnabled
    public static List<Contact> getClients()
    {
        // get  a list of clients, if nothing's there, return empty list
        return [SELECT Id, Name, AccountId FROM Contact WHERE RecordType.Name = 'Client'];
    }


    @AuraEnabled
    public static Meeting__c createMeeting(Meeting__c meeting, String strInterviewer, String strAssociate)
    {
        try{
            insert meeting;
            Contact interviewer = [SELECT Id FROM Contact WHERE Id =: strInterviewer];
            Contact associate = [SELECT Id FROM Contact WHERE Id =: strAssociate];

            List<Meeting_Participant__c> meetingParticipants = new List<Meeting_Participant__c>();

            //Adds the interviewer to the meeting
            meetingParticipants.add(new Meeting_Participant__c(Participant__c = interviewer.id, Meeting__c = meeting.Id));

            //Adds the selected associate will be added to the meeting
            meetingParticipants.add(new Meeting_Participant__c(Participant__c = associate.id, Meeting__c = meeting.Id));

        

            insert meetingParticipants;
            return meeting;
        } catch (Exception e) {
            return null;
        }
    }

    @AuraEnabled
    public static Meeting__c createMeetingAllBatch(Meeting__c meeting, String strInterviewer, List<Contact> fullBatch)
    {
        try {
            insert meeting;
            Contact interviewer = [SELECT Id FROM Contact WHERE Id =: strInterviewer];
            
            List<Meeting_Participant__c> meetingParticipants = new List<Meeting_Participant__c>();

            //Adds the interviewer to the meeting
            meetingParticipants.add(new Meeting_Participant__c(Participant__c = interviewer.id, Meeting__c = meeting.Id));

            //if no associate was selected, the entire batch will be added to the meeting
            for(Contact c : fullBatch)
            {
                meetingParticipants.add(new Meeting_Participant__c(Participant__c = c.Id, Meeting__c = meeting.Id));
            }

            insert meetingParticipants;
            return meeting;
        } catch (Exception e) {
            return null;
        }
    }
}