public with sharing class InterviewsListController {
    @AuraEnabled
    public static List<Meeting__c> getInterviews(){
        List<Meeting__c> yourInterviews = new List<Meeting__c>();
        for (Meeting__c m : [SELECT Client_Name__c, Location__c, Scheduled__c FROM Meeting__c WHERE Meeting_Status__c = 'On Schedule']) {
            yourInterviews.add(m);            
        }
        return yourInterviews;
    }
}
