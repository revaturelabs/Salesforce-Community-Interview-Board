public with sharing class GoogleCallout {
    
	public static Http http = new Http();
    public static HTTPResponse response;
    public static HttpRequest request;

   @AuraEnabled 
    public static void createEvent() {
        
        DateTime EndDateTime = DateTime.newInstance(2020, 9, 2, 21, 30, 00);
        DateTime StartDateTime = DateTime.newInstance(2020, 9, 2, 20, 30, 00);
        
        
        String Summary ='{"summary": "Apex Test with ID2",';
        String form = EndDateTime.formatGMT('yyyy-MM-d hh:mm:ss');
        system.debug(form);
        String forendDateTime ='"end": {"dateTime": "2020-08-29T21:30:00-04:00"},';
        String forstartDateTime = '"start": {"dateTime": "2020-07-29T20:00:00-04:00"},';
        String attend = '"attendees": [{"email": "example@gmail.com"}],';
        String confData = '"conferenceData": {"createRequest": {"requestId": "7qxalsvy0e"}}}';
        
        request = new HttpRequest();
        request.setMethod('POST');
        request.setBody(Summary + forendDateTime + forstartDateTime + attend + confData); 
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
        m.Google_Event_Id__c = eID;
        m.Meeting_Status__c = 'On Schedule';
      //  m.EndDateTime__c = endTime;
       // m.StartDateTime__c = startTime;
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
}