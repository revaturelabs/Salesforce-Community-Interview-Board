@isTest
public class MeetingControllerTestUtility {

     
    // Create meetings scheduled in google calendar

    public static List<Meeting__c> createScheduledMeetings(Integer numberToCreate){

    List<Meeting__c> meetings = new List<Meeting__c>();

        for(Integer i = 0; i < numberToCreate; i++){

            Meeting__c meeting = new Meeting__c();

            meeting.StartDateTime__c = Datetime.now();
            meeting.EndDateTime__c = meeting.StartDateTime__c.addHours(1);
            meeting.Meeting_Status__c = 'Scheduled';
            meeting.Google_Event_Id__c = 'bhrdutjfuhfe4ctlk33pt3o0lk';
            meeting.Stack__c = 'Java';

            meetings.add(meeting);
        }
        System.debug(meetings);
        return meetings;
    }

     // Create time slots not yet scheduled in google calendar

    public static List<Meeting__c> createTimeSlots(Integer numberToCreate){

    List<Meeting__c> meetings = new List<Meeting__c>();

        for(Integer i = 0; i < numberToCreate; i++){

            Meeting__c meeting = new Meeting__c();

            meeting.StartDateTime__c = Datetime.now();
            meeting.EndDateTime__c = meeting.StartDateTime__c.addHours(1);
            meeting.Meeting_Status__c = 'Scheduled';
            meeting.Google_Event_Id__c = null;
            meeting.Stack__c = 'Salesforce';
            meeting.Interviewer_Name__c = 'Bob Bobson';

            meetings.add(meeting);
        }
        System.debug(meetings);
        return meetings;
    }
    }