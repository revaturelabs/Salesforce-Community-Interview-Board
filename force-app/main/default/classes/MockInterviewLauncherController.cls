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
                meetinglist=  [SELECT Id, Name, Client_Name__c , Meeting_status__c , Scheduled__c , location__c, Notes__c, Display_Name__c
                               FROM Meeting__c
                               WHERE Id IN (SELECT Meeting__c 
                                            FROM Meeting_Participant__c 
                                           ) AND Scheduled__c > : System.now() AND RecordTypeId != : MockId ORDER BY Scheduled__c  ];
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
}
