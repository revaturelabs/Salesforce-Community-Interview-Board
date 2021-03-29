public with sharing class MockInterviewLauncherController {

    @auraenabled
    public static List<Question__c> GetInterviewQuestions(String meetingid) {
        //returns all interview_question objects that are related to the parameter meetingid 
        Meeting__c meet = [SELECT id, name FROM Meeting__c WHERE name =: meetingid];
        List<Interview_Question__c> interviewQuestionList = [SELECT id, Question__c FROM Interview_Question__c WHERE Meeting_md__c = : meet.id];
        List<Question__c> returnlist = new List<Question__c>{};

        try {
            for(Interview_Question__c q : interviewQuestionList)
            {
                Question__c newQ = [SELECT id, body__c, type__c FROM Question__c WHERE id=:q.Question__c];
                returnlist.add(newQ);
            }
        
        } catch(Exception e) {
                throw new AuraHandledException('Server-side Error: ' + e.getMessage()); 
        }

        return returnlist;
    }

    @auraenabled
    public static Meeting__c[] GetUpcomingMeetingsAll() {
        //returns all future meetings the logged in associate is a participant of that arent mock interviews
        list<Meeting__c>  meetinglist = new    list<Meeting__c>{}; 
            try {

                Id MockId = Schema.SObjectType.Meeting__c.getRecordTypeInfosByName().get('Mock Interview').getRecordTypeId();
                meetinglist=  [SELECT Id, Name, Notes__c, Display_Name__c
                               FROM Meeting__c
                               WHERE Id IN (SELECT Meeting__c 
                                            FROM Meeting_Participant__c 
                                           )  AND RecordTypeId = : MockId   ];
            } catch(Exception e) {
                throw new AuraHandledException('Server-side Error: ' + e.getMessage()); 
            }
        
        return meetinglist;
        
        
    }

    @auraenabled
    public static void UpdateResponseIQ(Question__c q, String response, String meet) {
        Meeting__c meeting = [SELECT id, name FROM Meeting__c WHERE name =: meet];
        Interview_Question__c newIQ = [SELECT id, response__c FROM Interview_Question__c WHERE Question__c=:q.Id AND Meeting_md__c = : meeting.id];
        newIQ.response__c = response;
        update newIQ;
        return;
    }

    @auraenabled
    public static void sendReview(String meet) {
        Meeting__c meeting = [SELECT id, name FROM Meeting__c WHERE name =: meet];
        List<Interview_Question__c> iqList = [SELECT id, response__c, Question__c FROM Interview_Question__c WHERE Meeting_md__c = : meeting.id];
        List<Meeting_Participant__c> mpList = [SELECT id, Meeting__c, Participant__c FROM Meeting_Participant__c WHERE Meeting__c =:meeting.id];

        List<Id> mpListIDs = new List<Id>();

        for(Meeting_Participant__c mp : mpList)
        {
            mpListIDs.add(mp.Participant__c);
        }

        Contact interviewee = [SELECT id, email, RecordType.Name FROM Contact WHERE RecordType.Name = 'Associate' AND id IN: mpListIDs];

        User userInterviewee = [SELECT id, ContactId, Email FROM User WHERE ContactId =: interviewee.id];

        // Now create a new single email message object
        // that will send out a single email to the addresses in the To, CC & BCC list.
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        // Strings to hold the email addresses to which you are sending the email.
        String[] toAddresses = new String[] {userInterviewee.Email}; 
        
        
        // Assign the addresses for the To and CC lists to the mail object.
        mail.setToAddresses(toAddresses);
        
        // Specify the address used when the recipients reply to the email. 
        mail.setReplyTo('noreply@revature.com');
        
        // Specify the name used as the display name.
        mail.setSenderDisplayName('Mock Interview Review');
        
        // Specify the subject line for your email address.
        mail.setSubject('Mock Interview Review : ' + meet);
        
        // Set to True if you want to BCC yourself on the email.
        mail.setBccSender(false);
        
        // Optionally append the salesforce.com email signature to the email.
        // The email address of the user executing the Apex Code will be used.
        mail.setUseSignature(false);
        
        // Specify the text content of the email.
       // mail.setPlainTextBody('Your Case: ' + case.Id +' has been created.');

       String iqListInfo = '';

       for (Interview_Question__c iq : iqList)
       {
           Question__c q = [SELECT id, body__c FROM Question__c WHERE id =:iq.Question__c];
           iqListInfo = iqListInfo + 'Question: ' + q.body__c + '<br>' + 'Response Notes: ' + iq.response__c + '<br><br>';
       }
        
        mail.setHtmlBody('Your mock interview:<b> ' + meet +' </b> has ended.<br><br>' + iqListInfo);
        
        // Send the email you have created.
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

        return;
    }
}