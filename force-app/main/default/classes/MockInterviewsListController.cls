public with sharing class MockInterviewsListController {
    @AuraEnabled
    public static List<Meeting__c> getInterviews(){
        List<Meeting__c> yourInterviews = new List<Meeting__c>();
        ID userId = System.UserInfo.getUserId();
        User userContactId = [Select Contact.id FROM USER WHERE ID = :userId];
        List<Id> meetingIdList = new List<Id>();
        for(Meeting_Participant__c meetParti : [SELECT Meeting__c FROM Meeting_Participant__c WHERE Participant__c = :userContactId.Contact.Id]){

            MeetingIdList.add(meetParti.Meeting__c);
        }

        for (Meeting__c m : [SELECT Name, Notes__c FROM Meeting__c WHERE RecordType.Name = 'Mock Interview' AND Id IN :meetingIdList]) {
            yourInterviews.add(m);            
        }
        return yourInterviews;
    }
}