public class MeetingListController {
	@AuraEnabled
   public static void updateMeetings(Meeting__c updateMeeting) {
       System.debug('this is the meeting:' +updateMeeting);
       Database.update( updateMeeting);
   }
}