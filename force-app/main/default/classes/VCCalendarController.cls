public without sharing class VCCalendarController {
    
    // Gets picklist values for all stack types
    
    @AuraEnabled
    public static List<String> getTypePicklistValues() {
        
        Map<String,List<String>> stackTypePicklistMap = Utilities.getTypePicklistValues();
        
        List<String> stackTypePicklist = new List<String>(stackTypePicklistMap.keySet());
        
        return stackTypePicklist;
    }
    
    
    // Gets the Id, Client Name, Start Time, and End Time of scheduled meetings
    
    @AuraEnabled
    public static Map<String, Meeting__c> getMeetings() {
        
        Map<String, Meeting__c> meetingDetails = new Map<String, Meeting__c>();
        
        List<Meeting__c> meetings = [SELECT Google_Event_Id__c, Client_Name__c, StartDateTime__c, EndDateTime__c FROM Meeting__c WHERE Google_Event_Id__c != null];
        
        if(meetings.size() > 0){
            
            for(Meeting__c meeting : meetings){
                
                meetingDetails.put(meeting.Google_Event_Id__c, meeting);
            }
        }
        return meetingDetails;   
    }
    
    // Converts start and end times associated with available time slots to a String for use in a picklist
    
    @AuraEnabled
    public static List<String> getTimeSlots() {
        
        List<String> timeSlots = new List<String>();
        
        List<Meeting__c> meetingTimeSlots = [SELECT StartDateTime__c, EndDateTime__c FROM Meeting__c WHERE Meeting_Status__c = 'Not Scheduled' AND Google_Event_Id__c = null];
        
        if(meetingTimeSlots.size() > 0){
            
            for(Meeting__c meeting : meetingTimeSlots){
                
                timeSlots.add(meeting.StartDateTime__c.format('MM/dd/yyyy HH:mm','America/New_York') + ' - ' + meeting.EndDateTime__c.format('HH:mm','America/New_York'));
            }
        }
        System.debug(timeSlots);
        return timeSlots;   
    }
    
    
     // Filters time slots and converts format for use in picklist
    
    @AuraEnabled
    public static List<String> getFilteredTimeSlots(String filter) {
        
        List<String> timeSlots = new List<String>();
        
        List<Meeting__c> meetingTimeSlots = [SELECT StartDateTime__c, EndDateTime__c FROM Meeting__c WHERE Meeting_Status__c = 'Not Scheduled' AND Google_Event_Id__c = null AND Stack__c = :filter];
        
        if(meetingTimeSlots.size() > 0){
            
            for(Meeting__c meeting : meetingTimeSlots){
                
                timeSlots.add(meeting.StartDateTime__c.format('MM/dd/yyyy HH:mm','America/New_York') + ' - ' + meeting.EndDateTime__c.format('HH:mm','America/New_York'));
            }
        }
        return timeSlots;   
    }
    
    // Change the meeting status for time slots not scheduled to awaiting approval
    
    @AuraEnabled
    public static List<String> setNeedsApprovalTimeSlots(String filter) {
        
        List<String> timeSlots = new List<String>();
        
        List<Meeting__c> meetingTimeSlots = [SELECT StartDateTime__c, EndDateTime__c FROM Meeting__c WHERE Meeting_Status__c = 'Not Scheduled' AND Google_Event_Id__c = null AND Stack__c = :filter];
        
        if(meetingTimeSlots.size() > 0){
            
            for(Meeting__c meeting : meetingTimeSlots){
                
                if((meeting.StartDateTime__c.format('MM/dd/yyyy HH:mm','America/New_York') + ' - ' + meeting.EndDateTime__c.format('HH:mm','America/New_York')) == filter){
                   
                    meeting.Meeting_Status__c = 'Awaiting Approval';
                    
                    timeSlots.add(meeting.StartDateTime__c.format('MM/dd/yyyy HH:mm','America/New_York') + ' - ' + meeting.EndDateTime__c.format('HH:mm','America/New_York'));
                }
            }
        }
        return timeSlots;   
    }

    @AuraEnabled
    public static Boolean hasScheduledMeetings() {
        
        Integer meeting = [SELECT Count() FROM Meeting__c WHERE Google_Event_Id__c != null];
        
        return (meeting > 0);   
    }
    
    @AuraEnabled
    public static Boolean hasUnScheduledTimeSlots() {
        
        Integer meeting = [SELECT Count() FROM Meeting__c WHERE Google_Event_Id__c = null];
        
        return (meeting > 0);   
    }
    
    // Determines wether the user has admin permissions to determine appropriate view
    
    @AuraEnabled
    public static Boolean getProfilePerm(){

        Boolean AdminPerm = FeatureManagement.checkPermission('AdminPermission');
        return AdminPerm;
    }
}