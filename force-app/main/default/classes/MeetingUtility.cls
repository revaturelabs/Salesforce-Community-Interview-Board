@isTest
public class MeetingUtility {
    
    
    // Create meetings scheduled in google calendar
    
    public static List<Meeting__c> createScheduledMeetings(Integer numberToCreate){
        
    List<Meeting__c> meetings = new List<Meeting__c>();
       
        for(Integer i = 0; i < numberToCreate; i++){
            
            Meeting__c meeting = new Meeting__c();
            
            meeting.StartDateTime__c = Datetime.now().addMinutes(i);
            meeting.EndDateTime__c = meeting.StartDateTime__c.addHours(1);
            meeting.Meeting_Status__c = 'Scheduled';
            meeting.Google_Event_Id__c = 'bhrdutjfuhfe4ctlk33pt3o0lk';
            
            meetings.add(meeting);
        }
        return meetings;
    }
    
     // Create time slots not yet scheduled in google calendar nor chosen by associate
    
    public static List<Meeting__c> createTimeSlots(Integer numberToCreate, String stack){
        
    List<Meeting__c> meetings = new List<Meeting__c>();
       
        for(Integer i = 0; i < numberToCreate; i++){
            
            Meeting__c meeting = new Meeting__c();
            
            meeting.StartDateTime__c = Datetime.now().addMinutes(i);
            meeting.EndDateTime__c = meeting.StartDateTime__c.addHours(1);
            meeting.Meeting_Status__c = 'Not Scheduled';
            meeting.Google_Event_Id__c = null;
            meeting.Stack__c = stack;
            
            meetings.add(meeting);
        }
        return meetings;
    }
    
   // Create time slots chosen by an associate but not yet scheduled in google calendar
    
    public static List<Meeting__c> createApprovals(Integer numberToCreate, String stack){
        
    List<Meeting__c> meetings = new List<Meeting__c>();
       
        for(Integer i = 0; i < numberToCreate; i++){
            
            Meeting__c meeting = new Meeting__c();
            
            meeting.StartDateTime__c = Datetime.now().addMinutes(i);
            meeting.EndDateTime__c = meeting.StartDateTime__c.addHours(1);
            meeting.Meeting_Status__c = 'Awaiting Approval';
            meeting.Google_Event_Id__c = null;
            meeting.Stack__c = stack;
            
            meetings.add(meeting);
        }
        return meetings;
    }
}