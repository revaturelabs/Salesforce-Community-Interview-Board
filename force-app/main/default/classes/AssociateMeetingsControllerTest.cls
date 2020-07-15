@isTest(seeAllData=True)
public class AssociateMeetingsControllerTest {    
    @isTest
    static void testAsCommunityUser(){
        //Create Test Community User with contact associated with it. 
        
        Contact con = [SELECT Id, Name FROM Contact WHERE Name = 'Arthur Song'];
        Profile prof = [select id from profile where name = 'Associate'];
        User u = new User(firstName = 'test1', lastName ='test2', profileId = prof.id, 
                          username = 'test@test.com', email = 'test@test.com', ContactId = con.Id,
                          alias= 'Test', TimeZoneSidKey='America/New_York', LocaleSidKey='en_US',
                          EmailEncodingKey='ISO-8859-1', LanguageLocaleKey='en_US', IsActive = true);
        insert u;
        
        System.runAs(u) {
            //Get Test User's Id and ContactId
            
            ID userId = System.UserInfo.getUserId();
            User userContactId = [Select Contact.Id FROM USER WHERE ID = :userId];
            //Create Meetings with Mock Interview and Non-Mock Interview Record Types
            
            Meeting__c[] meets = new Meeting__c[]{};
                Integer x = 3;
            For(Integer i=0; i < x; i++){
                meets.add(new Meeting__c(Name = 'Test Non-Mock Interview ' + (i+1), RecordTypeId = '0123h0000006O1SAAU',Scheduled__c = System.today()+ 3));
                meets.add(new Meeting__c(Name = 'Test Mock Interview ' + (i+1), RecordTypeId ='0123h0000006OXmAAM'));
                meets.add(new Meeting__c(Name = 'Test Past Interview Batch ' + (i+1), RecordTypeId = '0123h0000006O1VAAU', Scheduled__c = System.today() -3,Meeting_Status__c = 'Completed'));
                meets.add(new Meeting__c(Name = 'Test Past Interview 1-1 ' + (i+1), RecordTypeId = '0123h0000006O1UAAU', Scheduled__c = System.today() -3,Meeting_Status__c = 'Completed'));
            }
            insert meets;
            //For Each Meeting Just Inserted, Add Meeting Participants
            
            List<Meeting_Participant__c> persons = new List<Meeting_Participant__c>();
            for (Integer j=0;j<x*4;j++) {
                Meeting__c meet = meets[j];
                
                for (Integer k=0;k<1;k++) {
                    persons.add(new Meeting_Participant__c(Name=meet.Name + ' Participant ' + (k+1),
                                                           Meeting__c = meet.Id,
                                                           Participant__c = userContactId.ContactId
                                                          ));
                }
            }
            insert persons;
            //Create Interview Questions for a Test Meeting
            Question__c[] quests = new Question__c[]{};
                For(Integer i=0; i < x; i++){
                    quests.add(new Question__c(Name = 'Test'));
                }
            insert quests; 
            List<Interview_Question__c> questions = new List<Interview_Question__c>();
            Meeting__c testMeeting = meets[0];
            System.debug(testMeeting);
            
            for (Integer k=0;k<x;k++) {
                Question__c quest = quests[k];
                questions.add(new Interview_Question__c(Meeting_md__c = testMeeting.Id,
                                                        Question__c = quest.Id));
            }
            
            insert questions;
            Meeting__c meet = [SELECT Id FROM Meeting__c WHERE Name = 'Test Non-Mock Interview 1'];
            String meetingid = meet.Id;
            //Start Test
            
            Test.startTest();
            Meeting__c[] meetings = AssociateMeetingController.GetUpcomingMeetings();
            Meeting__c[] mockInterviews =  AssociateMeetingController.GetFutureMockInterviews();
            Meeting__c[] pastInterviews =  AssociateMeetingController.GetPastInterviews();
            Interview_Question__c[] interviewQuestions = AssociateMeetingController.GetInterviewQuestions(meetingid);
            
            //Stop Test
            
            Test.stopTest();
            //Check If the Controller Performs As Expected
            
            System.assertEquals(3, meetings.size());
            System.assertEquals(3, mockInterviews.size());
            System.assertEquals(6, pastInterviews.size());
            System.assertEquals(3, interviewQuestions.size());
        }
    }
}