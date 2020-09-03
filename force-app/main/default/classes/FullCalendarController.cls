public class FullCalendarController {

    @AuraEnabled
    public static List<Meeting__c> getMeetings() {
      /* Meeting__c newMeeting = new Meeting__c();
        newMeeting.EndDateTime__c = System.now();
        newMeeting.StartDateTime__c = System.now();
        newMeeting.Name = 'Test';
        insert newMeeting; */
        
        return [SELECT EndDateTime__c, StartDateTime__c, Name, Google_Event_Id__c FROM Meeting__c];
    }
       
}