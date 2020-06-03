@isTest
public with sharing class InterviewQuestionsTest {
//create yer test data    
    public static void makeQuestions(integer mCount, integer qCount)
    {
        List<Meeting__c> meets = new List<Meeting__c>();
        for(integer i = 0; i < mCount; i++)
            meets.add(new Meeting__c(Name='Test ' + i));
            
        insert meets;
        
        List<Interview_Question__c> ques = new List<Interview_Question__c>();

        if(mCount > 0)
            for(Meeting__c m : meets)
                for(integer i = 0; i < qCount; i++)
                    ques.add(new Interview_Question__c(Name='Ques ' + 1, Meeting__c=m.Id));
        else
            for(integer i = 0; i < qCount; i++)
                ques.add(new Interview_Question__c(Name='Ques ' + 1));

        insert ques;
    }

//test positive multiple records
//     @isTest
//     public static void MultipleBothTest()
//     {
//         makeQuestions(10, 10);

//         List<List<sObject>> result = InterviewQuestions.loadQuestionMap();

//         System.assertEquals(2, result.size());
//         System.assertEquals(10, result.get(0).size());
//         System.assertEquals(100, result.get(1).size());
//     }

//     @isTest
//     public static void MultipleMeetingNoQuestionTest()
//     {
//         makeQuestions(10, 0);

//         List<List<sObject>> result = InterviewQuestions.loadQuestionMap();

//         System.assertEquals(2, result.size());
//         System.assertEquals(10, result.get(0).size());
//         System.assertEquals(0, result.get(1).size());
//     }

//     @isTest
//     public static void MultipleQuestionNoMeetingTest()
//     {
//         makeQuestions(0, 10);

//         List<List<sObject>> result = InterviewQuestions.loadQuestionMap();

//         System.assertEquals(2, result.size());
//         System.assertEquals(0, result.get(0).size());
//         System.assertEquals(10, result.get(1).size());
//     }

// //test one record
//     @isTest
//     public static void OneBothTest()
//     {
//         makeQuestions(1, 1);

//         List<List<sObject>> result = InterviewQuestions.loadQuestionMap();

//         System.assertEquals(2, result.size());
//         System.assertEquals(1, result.get(0).size());
//         System.assertEquals(1, result.get(1).size());
//     }

//     @isTest
//     public static void OneMeetingNoQuestionTest()
//     {
//         makeQuestions(1, 0);

//         List<List<sObject>> result = InterviewQuestions.loadQuestionMap();

//         System.assertEquals(2, result.size());
//         System.assertEquals(1, result.get(0).size());
//         System.assertEquals(0, result.get(1).size());
//     }

//     @isTest
//     public static void OneQuestionNoMeetingTest()
//     {
//         makeQuestions(0, 1);

//         List<List<sObject>> result = InterviewQuestions.loadQuestionMap();

//         System.assertEquals(2, result.size());
//         System.assertEquals(0, result.get(0).size());
//         System.assertEquals(1, result.get(1).size());
//     }

// //test null?
//     @isTest
//     public static void NoEitherTest()
//     {
//         List<List<sObject>> result = InterviewQuestions.loadQuestionMap();

//         System.assertEquals(2, result.size());
//         System.assertEquals(0, result.get(0).size());
//         System.assertEquals(0, result.get(1).size());
//     }
 }