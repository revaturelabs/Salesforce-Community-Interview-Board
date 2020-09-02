public with sharing class MeetingController{

    
    //Method that checks whether the user has the custom Permission assigned to their Profile -- Returns true if they do
    @AuraEnabled
    public static Boolean getProfilePerm(){

        Boolean AdminPerm = FeatureManagement.checkPermission('AdminPermission');
        return AdminPerm;
    }
    
    @AuraEnabled
    public static String getMeeting(){
        Meeting__c testMeeting = [SELECT id, name, StartDateTime__c, EndDateTime__c, Meeting_Status__c FROM Meeting__c Limit 1];
        String meetingId = testMeeting.id;
        return meetingId;
        
    }
    
    //Method assumes user will always pick the same day for both start time and end time
      @AuraEnabled
      public static Integer createTimeslots(DateTime startTime, DateTime endTime){
      	
        	Integer hourLength = endTime.hour() - startTime.hour();
          	Integer minLength = (endTime.minute() - startTime.minute()) + (hourLength * 60);
          	Integer numTimeslot = minLength/60;
          	List<Meeting__c> timeslotList = new List<Meeting__c>();
          
          for(integer i = 0; i<numTimeslot; i++){
              system.debug(i);
              Meeting__c newMeeting = new Meeting__c();
              newMeeting.Meeting_Status__c = 'Not Scheduled';
              newMeeting.Name = 'Available Time Slot';
              newMeeting.StartDateTime__c = startTime;
 			  newMeeting.EndDateTime__c = startTime.addHours(1);
              startTime = startTime.addHours(1);
              timeslotList.add(newMeeting);
          }
          system.debug(timeslotList);
          insert timeslotList;
          
          return numTimeslot;
          
        
        
    }
    
}