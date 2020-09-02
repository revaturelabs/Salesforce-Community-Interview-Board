public with sharing class GoogleCallout {
    
	public static Http http = new Http();
    public static HTTPResponse response;
    public static HttpRequest request;

   @AuraEnabled 
    public static void createEvent() {
        
        DateTime EndDateTime = DateTime.newInstance(2020, 9, 2, 21, 30, 00);
        DateTime StartDateTime = DateTime.newInstance(2020, 9, 2, 20, 25, 00);
        
        String Summary ='{"summary": "Apex Test with ID2",';
        
        String endform = EndDateTime.formatGMT('yyyy-MM-dd hh:mm:ss');
        String startform = StartDateTime.formatGMT('yyyy-MM-dd hh:mm:ss');
        endform = endform.replace(' ', 'T');
        startform = startform.replace(' ', 'T');
        
        //system.debug(form);
        String forendDateTime ='"end": {"dateTime": "' + endform + '+03:00"},';
        String forstartDateTime = '"start": {"dateTime": "' + startform + '+03:00"},';
        //String attend = '"attendees": [{"email": "example@gmail.com"}],';
        String confData = '"conferenceData": {"createRequest": {"requestId": "7qxalsvy0e"}}}';
        
        request = new HttpRequest();
        request.setMethod('POST');
        request.setBody(Summary + forendDateTime + forstartDateTime + confData); 
        request.setEndpoint('callout:GoogleAPI/calendar/v3/calendars/salesforceibvc@gmail.com/events?conferenceDataVersion=1');
 
        response = http.send(request); 
 
       // System.debug(response.getBody());
        Map<String, Object> results;
        results = ( Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        String eID = results.get('id').toString();
        
        Map<String, Object> startDT = (Map<String, Object>) results.get('start'); 
        Map<String, Object> endDT = (Map<String, Object>) results.get('end');
        
		String endTime = endDT.get('dateTime').toString();
		String startTime = startDT.get('dateTime').toString();
        system.debug(endTime);
        System.debug(eID);
        
        
        
        Meeting__c m = new Meeting__c();
        m.name = Summary;
        m.Google_Event_Id__c = eID;
        m.Meeting_Status__c = 'On Schedule';
        m.EndDateTime__c = EndDateTime;
        m.StartDateTime__c = StartDateTime;
        insert m;
        
    }
    
    
	@AuraEnabled    
    public static String getEvent() {
        
        String eID = [SELECT Google_Event_Id__c FROM Meeting__c LIMIT 1].Google_Event_Id__c;
        system.debug(eID);
        request = new HTTPRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:GoogleAPI/calendar/v3/calendars/salesforceibvc@gmail.com/events/' + eID);
        response = http.send(request);
        
        system.debug(response.getBody());
        
        Map<String, Object> results;
        results = ( Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        String eMeet = results.get('hangoutLink').toString();
        
        system.debug(eMeet);
        return eMeet;
    }
    
    public static void updateEvent() {
        
        String eID = [SELECT Google_Event_Id__c FROM Meeting__c LIMIT 1].Google_Event_Id__c;
        
        request = new HTTPRequest();
        request.setMethod('PATCH');
        request.setEndpoint('callout:GoogleAPI/calendar/v3/calendars/salesforceibvc@gmail.com/events/' + eID);
        response = HTTP.send(request);
        
    }
}