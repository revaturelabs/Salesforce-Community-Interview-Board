@isTest
public class QQDataFactory_Test {

    
    
    @isTest
    public static void createQuestionTest(){
        List<sfqz__Quiz_Question__c> oldQuestions = [SELECT Name FROM sfqz__Quiz_Question__c];

        QuizQuestionDataFactory.CreateAllQuestions();
        
        List<sfqz__Quiz_Question__c> newQuestions = [SELECT Name FROM sfqz__Quiz_Question__c];
        
        System.assertNotEquals(oldQuestions, newQuestions);

    }
    
}