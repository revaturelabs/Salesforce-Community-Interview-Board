@isTest
public class FullCalendarControllerTest {
    
    @isTest
    public static void getMeetingsTest() {
        // Create test meetings
        List<Meeting__c> meetingList = new List<Meeting__c>();
        
        for(Integer i=0; i<3; i++) {
            Meeting__c tMeeting = new Meeting__c();
            tMeeting.Name = 'Test ' + i;
            tMeeting.StartDateTime__c = System.now();
            tMeeting.EndDateTime__c = tMeeting.StartDateTime__c.addHours(1);
            tMeeting.Stack__c = 'Salesforce';
            meetingList.add(tMeeting);
        }
        
        meetingList.get(0).Meeting_Status__c = 'Not Scheduled';
        meetingList.get(1).Meeting_Status__c = 'Awaiting Approval';
        meetingList.get(2).Meeting_Status__c = 'Scheduled';
        
        insert meetingList;
        
        // Check for successful getMeetings()
        List<Meeting__c> retMeetings = FullCalendarController.getMeetings();
        
        System.assertEquals(retMeetings.get(0).Meeting_Status__c,'Not Scheduled');
        System.assertEquals(retMeetings.get(1).Meeting_Status__c,'Awaiting Approval');
        System.assertEquals(retMeetings.get(2).Meeting_Status__c,'Scheduled');
    }

}