public class MeetingListController {
	@AuraEnabled
   public static List<Meeting__C> getMeetings() {
       return [SELECT Completed_Date__c, Feedback__c, Location__c, Meeting_Status__c,
       Notes__c, Participating_Client__c, Scheduled__c FROM Meeting__C ORDER BY LastModifiedDate];
   }
}
