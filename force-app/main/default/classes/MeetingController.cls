public with sharing class MeetingController{

    public static Http http = new Http();
    public static HTTPResponse response;
    public static HttpRequest request;

    //Method that checks whether the user has the custom Permission assigned to their Profile -- Returns true if they do
    @AuraEnabled
    public static Boolean getProfilePerm(){

        Boolean AdminPerm = FeatureManagement.checkPermission('AdminPermission');
        return AdminPerm;
    }
    
    
    @AuraEnabled 
    public static void createEvent(String meetId, String sum, DateTime startDate, DateTime endDate) {
        
        DateTime EndDateTime = DateTime.newInstance(2020, 9, 4, 21, 30, 00);
        DateTime StartDateTime = DateTime.newInstance(2020, 9, 4, 20, 25, 00);         
        
        String Summary ='{"summary": "' + sum + '",';
        
        String endform = endDate.formatGMT('yyyy-MM-dd hh:mm:ss');
        String startform = startDate.formatGMT('yyyy-MM-dd hh:mm:ss');
        endform = endform.replace(' ', 'T');
        endform = endform.replace('.000Z', '');
        startform = startform.replace(' ', 'T');
        startform = startform.replace('.000Z', '');
        
        system.debug(sum);
        system.debug(endDate);
        system.debug(startDate);
        
        //system.debug(form);
        String forendDateTime ='"end": {"dateTime": "' + endform + '-12:00"},';
        String forstartDateTime = '"start": {"dateTime": "' + startform + '-12:00"},';
        //String attend = '"attendees": [{"email": "example@gmail.com"}],';
        String confData = '"conferenceData": {"createRequest": {"requestId": "7qxalsvy0e"}}}';
        
        request = new HttpRequest();
        request.setMethod('POST');
        request.setBody(Summary + forendDateTime + forstartDateTime + confData); 
        request.setEndpoint('callout:GoogleAPI/calendar/v3/calendars/salesforceibvc@gmail.com/events?conferenceDataVersion=1');
 
        response = http.send(request); 
 
        System.debug(response.getBody());
        Map<String, Object> results;
        results = ( Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        String eID = results.get('id').toString();
        
        System.debug(eID);
        
        Map<String, Object> startDT = (Map<String, Object>) results.get('start'); 
        Map<String, Object> endDT = (Map<String, Object>) results.get('end');
        
		String endTime = endDT.get('dateTime').toString();
		String startTime = startDT.get('dateTime').toString();
       // system.debug(endTime);
        //System.debug(eID);
        
        
        
        //Meeting__c m = new Meeting__c();
       // m.name = Summary;
        //m.Google_Event_Id__c = eID;
        //m.Meeting_Status__c = 'Scheduled';
        //m.EndDateTime__c = EndDate;
        //m.StartDateTime__c = startDate;
        
        try {
            
            Meeting__c meet = [SELECT id, Google_Event_Id__c, EndDateTime__c, StartDateTime__c, Name, Meeting_Status__c FROM Meeting__c WHERE id = :meetId];
            
            meet.Google_Event_Id__c = eID;
            meet.Meeting_Status__c = 'Scheduled';
            meet.EndDateTime__c = EndDate;
            meet.StartDateTime__c = startDate;
            meet.name= Summary;
            update meet;
        }
        catch(Exception e) {
            String error = e.getMessage();
            system.debug(error);
        }
       
    }
    
    /*
    @AuraEnabled
    public static String getMeeting(){
        Meeting__c testMeeting = [SELECT id, name, StartDateTime__c, EndDateTime__c, Meeting_Status__c, Stack__c FROM Meeting__c Limit 1];
        String meetingId = testMeeting.id;
        return meetingId;
        
    }*/
    
    //Method assumes user will always pick the same day for both start time and end time
      @AuraEnabled
      public static Integer createTimeslots(DateTime startTime, DateTime endTime, String tStack){
      	
        	Integer hourLength = endTime.hour() - startTime.hour();
          	Integer minLength = (endTime.minute() - startTime.minute()) + (hourLength * 60);
          	Integer numTimeslot = minLength/60;
          	List<Meeting__c> timeslotList = new List<Meeting__c>();
          
          for(integer i = 0; i<numTimeslot; i++){
              system.debug(i);
              Meeting__c newMeeting = new Meeting__c();
              newMeeting.Meeting_Status__c = 'Not Scheduled';
              newMeeting.Name = 'Available Time Slot';
              newMeeting.Stack__c = tStack;
              newMeeting.StartDateTime__c = startTime;
 			  newMeeting.EndDateTime__c = startTime.addHours(1);
              startTime = startTime.addHours(1);
              timeslotList.add(newMeeting);
          }
          system.debug(timeslotList);
          insert timeslotList;
          
          return numTimeslot;
                  
    }
    
    @AuraEnabled
    public static String[] getActiveStacks() {
        List<String> activeStacks = new List<String>();
		Schema.DescribeFieldResult fieldResult = Meeting__c.Stack__c.getDescribe();
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		for( Schema.PicklistEntry pickListVal : ple){
			activeStacks.add(pickListVal.getLabel());
		}     
		return activeStacks;
    }
    
}