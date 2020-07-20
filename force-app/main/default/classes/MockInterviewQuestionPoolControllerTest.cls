@isTest
public class MockInterviewQuestionPoolControllerTest {
    @testSetup
    static void setup(){
        //Create a test Mock Interview to hold the questions
        Id recordTypeId = Schema.sObjectType.Meeting__c.getRecordTypeInfosByName().get('Mock Interview').getRecordTypeId();
        Meeting__c testMeeting = new Meeting__c(Name = 'Test Meeting', RecordTypeId = recordTypeId);
        insert testMeeting;
        
        //Create Interview Questions for a Test Meeting
        Integer x = 3;
        Question__c[] questions = new Question__c[]{};
            For(Integer i=0; i < x; i++){
                questions.add(new Question__c(Name = 'Test', Stack__c = 'Salesforce', Type__c = 'Apex'));
            }
        insert questions;
        List<Interview_Question__c> interviewQuestions = new List<Interview_Question__c>();
        
        for (Integer k=0;k<x;k++) {
            Question__c quest = questions[k];
            interviewQuestions.add(new Interview_Question__c(Meeting_md__c = testMeeting.Id,
                                                             Question__c = quest.Id));
        }
        insert interviewQuestions;     
    }
    
    @isTest
    static void testGetQuestionPool(){
        //Get the meeting Id needed for the method call
        Meeting__c meeting = [SELECT Id FROM Meeting__c];
        Id ParentId = meeting.Id;
        Test.startTest();
        Interview_Question__c[] retrievedQuestions = MockInterviewQuestionPoolController.getQuestionPool(ParentId);
        Test.stopTest();
        //Check to see that the correct number of questions was retrieved from the list of Interview Questions.
        System.assertEquals(3, retrievedQuestions.size() );
    }
    
    @isTest
    static void testDeleteQuestions(){
        //Get the list of Interview Questions and delete all but 1 question. 
        List<Interview_Question__c> questions = [SELECT Id FROM Interview_Question__c];
        Id[] idList = new Id[]{};
            for(Integer i = 0; i<questions.size()-1; i++){
                idList.add(questions[i].Id);
            }
        List<Interview_Question__c> allQuestions = [SELECT Id FROM Interview_Question__c];
        Test.startTest();
        MockInterviewQuestionPoolController.deleteQuestions(idList);
        Test.stopTest();
        List<Interview_Question__c> afterTestQuestions = [SELECT Id FROM Interview_Question__c];
        //Check to see if the list size of the questions before the controller method call is not the same
        //as the list size of the questions after the controller method call.
        System.assertNotEquals(allQuestions.size(), afterTestQuestions.size());
        //Check to see that the correct number of questions was deleted from the list of Interview Questions.
        System.assertEquals(1, afterTestQuestions.size());
    }
}