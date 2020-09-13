public with sharing class GoogleCallout {
    
    //HTTP Objects
	public static Http http = new Http();
    public static HTTPResponse response;
    public static HttpRequest request;

   @AuraEnabled 
    public static void createEvent(String s, DateTime startDate, DateTime endDate) {
        //Debug
        system.debug(s);
        system.debug(endDate);
        system.debug(startDate);
        
        //Assign the meeting name
        String Summary = '"summary": "' + s + '"';
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
        Meeting__c m = new Meeting__c();
        m.name = Summary;
        m.Google_Event_Id__c = eID;
        m.Meeting_Status__c = 'Scheduled';
        m.EndDateTime__c = EndDate;
        m.StartDateTime__c = startDate;
        
    	//Insert Meeting
        insert m;
    }
    
    
	@AuraEnabled    
    public static String getEvent() {
        //Get Google Event ID with Query
        String eID = [SELECT Google_Event_Id__c FROM Meeting__c LIMIT 1].Google_Event_Id__c;
        system.debug(eID);
        
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
    
    @AuraEnabled
    public static void updateEvent(String EID, String s, DateTime startDate, DateTime endDate) {
        //Debug
        system.debug(EID);
        system.debug(s);
        system.debug(startDate);
        system.debug(endDate);
        
        //Assign the meeting name
        String Summary = '"summary": "' + s + '"';
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
        
        //Put Body together
        String body = '{'+summary+','+startForm+','+endForm+'}';
        system.debug(body);
       
  		//HTTP Request
        request = new HTTPRequest();
        request.setMethod('PUT');
        request.setBody(body);
        request.setEndpoint('callout:GoogleAPI/calendar/v3/calendars/salesforceibvc@gmail.com/events/' + EID);
        
        //HTTP Response
        response = HTTP.send(request);
        system.debug(response.getBody());

        
    }
}