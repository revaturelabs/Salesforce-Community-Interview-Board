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
    public static List<String> getMeetings() {
        
        List<String> meetingTimes = new List<String>();
        
        List<Meeting__c> meetings = [SELECT StartDateTime__c, EndDateTime__c FROM Meeting__c WHERE Meeting_Status__c = 'Scheduled' AND Google_Event_Id__c != null];
        
        if(meetings.size() > 0){
            
            for(Meeting__c meeting : meetings){
                
                meetingTimes.add(meeting.StartDateTime__c.format('MM/dd/yyyy HH:mm','America/New_York') + ' - ' + meeting.EndDateTime__c.format('HH:mm','America/New_York'));
            }
        }
        System.debug(meetingTimes);
        return meetingTimes;   
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
    
    // Converts start and end times associated with time slots awaiting approval to a String for use in a picklist
    
    @AuraEnabled
    public static List<String> getNeedsApprovalTimeSlots() {
        
        List<String> timeSlots = new List<String>();
        
         List<Meeting__c> approvalTimeSlots = [SELECT StartDateTime__c, EndDateTime__c FROM Meeting__c WHERE Meeting_Status__c = 'Awaiting Approval' AND Google_Event_Id__c = null];
        
        if(approvalTimeSlots.size() > 0){
            for(Meeting__c meeting : approvalTimeSlots){
                
                timeSlots.add(meeting.StartDateTime__c.format('MM/dd/yyyy HH:mm','America/New_York') + ' - ' + meeting.EndDateTime__c.format('HH:mm','America/New_York'));
            }
        }
        return timeSlots;   
    }
    
    // Change the meeting status for time slots not scheduled to awaiting approval
    
    @AuraEnabled
    public static List<String> setNeedsApprovalTimeSlots(String filter) {
        
        System.debug(filter);
        
        List<String> timeSlots = getNeedsApprovalTimeSlots();
        
        List<Meeting__c> meetingTimeSlots = [SELECT StartDateTime__c, EndDateTime__c FROM Meeting__c WHERE Meeting_Status__c = 'Not Scheduled' AND Google_Event_Id__c = null];
        
        if(meetingTimeSlots.size() > 0){
            
            for(Meeting__c meeting : meetingTimeSlots){
                
                if((meeting.StartDateTime__c.format('MM/dd/yyyy HH:mm','America/New_York') + ' - ' + meeting.EndDateTime__c.format('HH:mm','America/New_York')) == filter){
                    
                    System.debug('Match found.');
                    meeting.Meeting_Status__c = 'Awaiting Approval';
                    meeting.Name = 'Awaiting Approval';
                    
                    timeSlots.add(filter);
                }
            }
        }
        try{
            update meetingTimeSlots;
            System.debug('Match updated.');
        }
        catch(DMLException e){
            System.debug('New time slots could not be updated: ' + e.getMessage());
        }
        System.debug(timeSlots);
        return timeSlots;   
    }
    
    // Get meeting id for meetings awaiting approval
    
    @AuraEnabled
    public static Id getApprovalId(String filter) {
        
        System.debug(filter);
        
        Id eventId;
        
        List<Meeting__c> meetingsAwaitingApproval = [SELECT Id, StartDateTime__c, EndDateTime__c FROM Meeting__c WHERE Meeting_Status__c = 'Awaiting Approval' AND Google_Event_Id__c = null];
        
        if(meetingsAwaitingApproval.size() > 0){
            
            for(Meeting__c meeting : meetingsAwaitingApproval){
                
                if((meeting.StartDateTime__c.format('MM/dd/yyyy HH:mm','America/New_York') + ' - ' + meeting.EndDateTime__c.format('HH:mm','America/New_York')) == filter){
                    
                    System.debug('Match found.');
                    meeting.Name = 'Scheduled';
                    
                    eventId = meeting.Id;
                }
            }
        }
        try{
            update meetingsAwaitingApproval;
            System.debug('Match updated.');
        }
        catch(DMLException e){
            System.debug('New meetings could not be approved: ' + e.getMessage());
        }
        System.debug(eventId);
        return eventId;   
    }
    
    // Get meeting id for meetings already created in Google Calendar
    
    @AuraEnabled
    public static Id getId(String filter) {
        
        System.debug(filter);
        
        Id eventId;
        
        List<Meeting__c> meetingsToUpdate = [SELECT Id, StartDateTime__c, EndDateTime__c FROM Meeting__c WHERE Google_Event_Id__c != null];
        
        if(meetingsToUpdate.size() > 0){
            
            for(Meeting__c meeting : meetingsToUpdate){
                
                if((meeting.StartDateTime__c.format('MM/dd/yyyy HH:mm','America/New_York') + ' - ' + meeting.EndDateTime__c.format('HH:mm','America/New_York')) == filter){
                    
                    System.debug('Match found.');
                    eventId = meeting.Id;
                }
            }
        }
        try{
            update meetingsToUpdate;
            System.debug('Match updated.');
        }
        catch(DMLException e){
            System.debug('New meetings could not be updated: ' + e.getMessage());
        }
        System.debug(eventId);
        return eventId;   
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