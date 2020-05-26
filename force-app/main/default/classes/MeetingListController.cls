public class MeetingListController {
	@AuraEnabled
   public static List<Meeting__C> getMeetings() {
       return [SELECT Completed_Date__c
       FROM Meeting__C ORDER BY LastModifiedDate];
   }
}