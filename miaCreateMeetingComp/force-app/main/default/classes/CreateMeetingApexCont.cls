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
    public static Meeting__c createMeeting(Meeting__c meeting, String strBatch, String strInterviewer, String strAssociate)
    {
        System.debug(strAssociate);
        Database.SaveResult msert = Database.insert(meeting);
        Account batch = [SELECT Id FROM Account WHERE Id =: strBatch];
        Contact interviewer = [SELECT Id FROM Contact WHERE Id =: strInterviewer];
        Contact associate = null;
        if(strAssociate != null)
            associate = [SELECT Id FROM Contact WHERE Id =: strAssociate];

        if(msert.isSuccess())
        {
            meeting = [SELECT Id FROM Meeting__c WHERE Id =: msert.getId()];
            //Queries all individual associates in a batch
            List<Contact> fullBatch = [SELECT Id FROM Contact WHERE AccountId =: batch.Id];

            List<Meeting_Participant__c> meetingParticipants = new List<Meeting_Participant__c>();

            //Adds the interviewer to the meeting
            meetingParticipants.add(new Meeting_Participant__c(Participant__c = interviewer.id, Meeting__c = meeting.id));

            //if an associate was selected, only that associate will be added to the meeting
            if(associate!=null)                  
                meetingParticipants.add(new Meeting_Participant__c(Participant__c = associate.id, Meeting__c = meeting.id));

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
        return null;
    }

    @AuraEnabled
    public static Meeting__c createMeetingAllBatch(Meeting__c meeting, String strBatch, String strInterviewer, List<Contact> fullBatch)
    {
        Database.SaveResult msert = Database.insert(meeting);
        Account batch = [SELECT Id FROM Account WHERE Id =: strBatch];
        Contact interviewer = [SELECT Id FROM Contact WHERE Id =: strInterviewer];

        if(msert.isSuccess())
        {
            meeting = [SELECT Id FROM Meeting__c WHERE Id =: msert.getId()];
            
            List<Meeting_Participant__c> meetingParticipants = new List<Meeting_Participant__c>();

            //Adds the interviewer to the meeting
            meetingParticipants.add(new Meeting_Participant__c(Participant__c = interviewer.id, Meeting__c = meeting.id));

            //if no associate was selected, the entire batch will be added to the meeting
            for(Contact c : fullBatch)
                {
                    meetingParticipants.add(new Meeting_Participant__c(Participant__c = c.Id, Meeting__c = meeting.Id));
                }

            insert meetingParticipants;
            return meeting;
        }
        return null;
    }
}