@isTest
global class createEventMock implements HttpCalloutMock{
	
    
    // Creates a mock callout to a premade google event to be used in the MeetingController Test class method 'createEventTest'
    global HTTPResponse respond(HTTPRequest request){        
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{ "kind": "calendar#event", "etag": "\'3197291643760000\'", "id": "2d1sh8i3n9issave6emr0p4koe", "status": "confirmed", "htmlLink": "https://www.google.com/calendar/event?eid=MmQxc2g4aTNuOWlzc2F2ZTZlbXIwcDRrb2Ugc2FsZXNmb3JjZWlidmNAbQ", "created": "2020-08-28T20:17:01.000Z", "updated": "2020-08-28T20:17:01.880Z", "summary": "Test Event 2", "creator": { "email": "salesforceibvc@gmail.com", "self": true },"organizer": {"email": "salesforceibvc@gmail.com", "self": true}, "start": { "dateTime": "2020-08-30T11:30:00-04:00" }, "end" : {"dateTime": "2020-08-30T12:30:00-04:00"}, "iCalUID" : "2d1sh8i3n9issave6emr0p4koe@google.com", "sequence": 0, "hangoutLink": "https://meet.google.com/gti-ecrv-ahg", "conferenceData" : {"entryPoints" : [{"entryPointType": "video", "uri" : "https://meet.google.com/gti-ecrv-ahg", "label" : "meet.google.com/gti-ecrv-ahg"}], "conferenceSolution": {"key" : { "type" : "hangoutsMeet"}, "name" : "Google Meet", "iconUri" : "https://lh5.googleusercontent.com/proxy/bWvYBOb7O03a7HK5iKNEAPoUNPEXH1CHZjuOkiqxHx8OtyVn9sZ6Ktl8hfqBNQUUbCDg6T2unnsHx7RSkCyhrKgHcdoosAW8POQJm_ZEvZU9ZfAE7mZIBGr_tDlF8Z_rSzXcjTffVXg3M46v"}, "conferenceId" : "gti-ecrv-ahg", "signature" : "ADR/mfNUVWNbyEb9FwR+7XhcdtPa"}, "reminders" : { "useDefault" : true} }');
        response.setStatusCode(200);
        
        return response;
    }
    
    
    
    
}