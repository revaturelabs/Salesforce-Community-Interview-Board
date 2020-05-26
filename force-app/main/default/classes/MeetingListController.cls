public class MeetingListController {
	@AuraEnabled
   public static void updateMeetings(List<Meeting__c> listToUpdate) {
       update listToUpdate;
   }
}
