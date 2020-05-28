public with sharing class associateInterviewController {
	@AuraEnabled
    public static List<Meeting__c> getMeetings() {
		return [SELECT Id, Name, Completed_Date__c FROM Meeting__c WHERE Completed_Date__c != null];
    }
}
