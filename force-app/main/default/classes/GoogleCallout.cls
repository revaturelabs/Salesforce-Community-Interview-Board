public with sharing class GoogleCallout {
    
	public static Http http = new Http();
    public static HTTPResponse response;
    public static HttpRequest request;

   @AuraEnabled 
    public static void createEvent() {
        
        String Summary ='{"summary": "Apex Test with ID2",';
        String endDateTime ='"end": {"dateTime": "2020-08-29T21:30:00-04:00"},';
        String startDateTime = '"start": {"dateTime": "2020-07-29T20:00:00-04:00"},';
        String attend = '"attendees": [{"email": "example@gmail.com"}],';
        String confData = '"conferenceData": {"createRequest": {"requestId": "7qxalsvy0e"}}}';
        
        request = new HttpRequest();
        request.setMethod('POST');

        request.setBody(Summary + endDateTime + startDateTime + attend + confData); 
        request.setEndpoint('callout:GoogleAPI/calendar/v3/calendars/salesforceibvc@gmail.com/events?conferenceDataVersion=1');
 
        response = http.send(request); 
 
       // System.debug(response.getBody());
        Map<String, Object> results;
        results = ( Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        String eID = results.get('id').toString();
        

        System.debug(eID);
        
        Meeting__c m = new Meeting__c();
        m.Google_Event_Id__c = eID;
        m.Meeting_Status__c = 'On Schedule';
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