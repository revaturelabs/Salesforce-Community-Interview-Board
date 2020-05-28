public with sharing class associateInterviewController {
	@AuraEnabled
    public static List<Meeting__c> associateSearch(String associateId) {
		List<Meeting_Participant__c> participants;
		try {
			participants = [SELECT Meeting__r.Id FROM Meeting_Participant__c WHERE Participant__r.Id = :associateId];
		} catch (QueryException qe) {
			return new List<Meeting__c>();
		}
		List<Id> meetingIds = new List<Id>();
		for (Meeting_Participant__c p : participants) {
			meetingIds.add(p.Meeting__r.Id);
		}
		return [SELECT Id, Name, Scheduled__c FROM Meeting__c WHERE Id IN :meetingIds];
    }
}
