public with sharing class AssociateMeetingsController {
	@AuraEnabled
    public static List<Meeting__c> getMeetings(String AId) {
		list<Meeting_participant__C> MPList= [SELECT Meeting__C from Meeting_Participant__C where Participant__C = :AId];
        list<Meeting__C> MList = new List<Meeting__C>();
        for(Meeting_Participant__C MP : MPList){
			MList.add([SELECT Name, Completed_Date__c, Client_Name__C FROM Meeting__c WHERE Id = :MP.Meeting__c LIMIT 1]) ;
        }
        system.debug(mlist);
        return MList;
    }
}