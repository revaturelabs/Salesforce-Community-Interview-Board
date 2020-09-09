@isTest
public class QQDataFactory_Test {
    @isTest
    public static void createQuestionTest(){
        List<Quiz_Question__c> oldQuestions = [SELECT Name FROM Quiz_Question__c];

        QuizQuestionDataFactory.CreateAllQuestions();
        
        List<Quiz_Question__c> newQuestions = [SELECT Name FROM Quiz_Question__c];
        
        System.assertNotEquals(oldQuestions, newQuestions);

    }
    
}