public class MeetingListController {
	@AuraEnabled
   public static void updateMeetings(Meeting__c UpdateMeeting) {
       Database.update(UpdateMeeting);
   }
}