public with sharing class MockInterviewsListController {
    @AuraEnabled
    public static List<Meeting__c> getInterviews(){
        List<Meeting__c> yourInterviews = new List<Meeting__c>();
        for (Meeting__c m : [SELECT Name, Notes__c FROM Meeting__c WHERE RecordType.Name = 'Mock Interview']) {
            yourInterviews.add(m);            
        }
        return yourInterviews;
    }
}
