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
    public static void createEvent(String intName, String meetId, String sum, DateTime startDate, DateTime endDate) {
        //Debug
        system.debug(sum);
        system.debug(endDate);
        system.debug(startDate);
        
        //Assign the meeting name
        String Summary = '"summary": "' + sum + ' | ' + intName + '"';
        system.debug(Summary);
        
        //Format the Start DateTime
        String startEdit = startDate.formatGMT('yyyy-MM-dd hh:mm:ss');
        startEdit = startEdit.replace(' ', 'T');
        startEdit = startEdit.replace('.000Z', '');
        String startForm = '"start": {"dateTime": "' + startEdit + '-12:00"}';
        system.debug(startForm);
        
        //Format the End DateTime
        String endEdit = endDate.formatGMT('yyyy-MM-dd hh:mm:ss');
        endEdit = endEdit.replace(' ', 'T');
        endEdit = endEdit.replace('.000Z', '');
        String endForm ='"end": {"dateTime": "' + endEdit + '-12:00"}';
        system.debug(endForm);
        
        //Conference Data for requesting a Google Meet
        String confData = '"conferenceData": {"createRequest": {"requestId": "7qxalsvy0e"}}';
        system.debug(confData);
        
        //Put Body together
        String body = '{'+summary+','+startForm+','+endForm+','+confData+'}';
        system.debug(body);
        
        //HTTP Request
        request = new HttpRequest();
        request.setMethod('POST');
        request.setBody(body); 
        request.setEndpoint('callout:GoogleAPI/calendar/v3/calendars/salesforceibvc@gmail.com/events?conferenceDataVersion=1');
 
        //HTTP Response
        response = http.send(request); 
        System.debug(response.getBody());
 		
        //Format Response
        Map<String, Object> results = ( Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        System.debug(results);
        
        //Get Google Event ID
        String eID = results.get('id').toString();
        System.debug(eID);
        
        //Get Start DateTime for verification
        Map<String, Object> startMap = (Map<String, Object>) results.get('start'); 
        String startString = startMap.get('dateTime').toString();
        System.debug(startString);
        
        //Get End DateTime for verification
        Map<String, Object> endMap = (Map<String, Object>) results.get('end');
		String endString = endMap.get('dateTime').toString();
        System.debug(endString);
        
        //Create Meeting
           try {
            
            Meeting__c m = [SELECT id, Google_Event_Id__c, EndDateTime__c, StartDateTime__c, Name, Meeting_Status__c FROM Meeting__c WHERE id = :meetId];
            
            m.Google_Event_Id__c = eID;
            //m.Meeting_Status__c = 'Scheduled'  + ' | ' + intName;
            m.Meeting_Status__c = 'Scheduled';
            m.EndDateTime__c = EndDate;
            m.StartDateTime__c = startDate;
            m.name= sum + '|' + intName;
            update m;
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
      public static Integer createTimeslots( String intName, DateTime startTime, DateTime endTime, String tStack){
      	
          if(startTime > endTime) {
              return 0;
          }
          	
        	Integer hourLength = endTime.hour() - startTime.hour();
          	Integer minLength = (endTime.minute() - startTime.minute()) + (hourLength * 60);
          	Integer numTimeslot = minLength/60;
          	List<Meeting__c> timeslotList = new List<Meeting__c>();
          
          for(integer i = 0; i<numTimeslot; i++){
              system.debug(i);
              Meeting__c newMeeting = new Meeting__c();
              newMeeting.Meeting_Status__c = 'Not Scheduled';
              newMeeting.Name = 'Available Time Slot' + ' | ' + intName;
              newMeeting.Stack__c = tStack;
              newMeeting.StartDateTime__c = startTime;
 			  newMeeting.EndDateTime__c = startTime.addHours(1);
              newMeeting.Interviewer_Name__c = intName;
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
    
    @AuraEnabled    
    public static String getEvent(String meetingId) {
        //Get Google Event ID with Query
        String eId = [SELECT Google_Event_Id__c FROM Meeting__c WHERE Id = :meetingId].Google_Event_Id__c;
        //system.debug(eID);
        
        //HTTP Request
        request = new HTTPRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:GoogleAPI/calendar/v3/calendars/salesforceibvc@gmail.com/events/' + eID);
        
        //HTTP Response
        response = http.send(request);
        system.debug(response.getBody());
        
        //Format Response
        Map<String, Object> results = ( Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        System.debug(results);
        
        //Get Google Event Hangout Link
        String meetLink = results.get('hangoutLink').toString();
        system.debug(meetLink);
        
        //Return Link
        return meetLink;
    }
    
}