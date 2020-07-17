@isTest
public class QuestionPoolApexControllerTest {
    @TestSetup
    static void makeData(){
        List<Question__c> allQuestions = new List<Question__c>();
        Question__c question;
        for (Integer i= 0; i<300; i++) {
            allQuestions.add(new Question__c(Name= 'Test Question '+i,Stack__c='Salesforce',Type__c='Apex'));
        }
        insert allQuestions;
    }

    @isTest
    public static void getQuestionPoolPositiveTest() {
        List<Question__c> qList = QuestionPoolApexController.getQuestionPool();
        System.assertEquals(300, qList.size());
    }

    @isTest
    public static void deleteQuestionsPositiveTest() {
        Question__c question = [SELECT Id FROM Question__c WHERE Name='Test Question 37'];
        String qId = question.Id;
        System.assertEquals(300, [SELECT Id FROM Question__c].size());
        QuestionPoolApexController.deleteQuestions(new List<String>{qId});
        System.assertEquals(299, [SELECT Id FROM Question__c].size());
    }

    @isTest
    public static void deleteQuestionsNegative2DeletesTest() {
        Question__c question = [SELECT Id FROM Question__c WHERE Name='Test Question 58'];
        String qId = question.Id;
        System.assertEquals(300, [SELECT Id FROM Question__c].size());
        QuestionPoolApexController.deleteQuestions(new List<String>{qId});
        QuestionPoolApexController.deleteQuestions(new List<String>{qId});
        System.assertEquals(299, [SELECT Id FROM Question__c].size());
    }

    @isTest
    public static void deleteQuestionsNegativeNullTest() {
        System.assertEquals(300, [SELECT Id FROM Question__c].size());
        QuestionPoolApexController.deleteQuestions(new List<String>{null});
        System.assertEquals(300, [SELECT Id FROM Question__c].size());
    }

    @isTest
    public static void deleteQuestionsPositiveBulkTest() {
        List<String> questionNames = new List<String>();
        for (Integer i= 0; i<100; i++) {
            questionNames.add('Test Question '+i);
        }
        List<Question__c> questions = [SELECT Id FROM Question__c WHERE Name IN :questionNames];
        List<String> idList = new List<String>();
        for(Question__c q : questions) {
            idList.add(q.Id);
        }
        System.assertEquals(300, [SELECT Id FROM Question__c].size());
        QuestionPoolApexController.deleteQuestions(idList);
        System.assertEquals(200, [SELECT Id FROM Question__c].size());
    }

    @isTest
    public static void deleteQuestionsNegativeBulkTest() {
        List<String> questionNames = new List<String>();
        for (Integer i= 0; i<100; i++) {
            questionNames.add('Test Question '+i);
        }
        List<Question__c> questions = [SELECT Id FROM Question__c WHERE Name IN :questionNames];
        List<String> idList = new List<String>();
        for(Question__c q : questions) {
            idList.add(q.Id);
        }
        String singleId = idList[0];

        System.assertEquals(300, [SELECT Id FROM Question__c].size());
        QuestionPoolApexController.deleteQuestions(new String[]{singleId});
        System.assertEquals(299, [SELECT Id FROM Question__c].size());
        QuestionPoolApexController.deleteQuestions(idList);
        System.assertEquals(200, [SELECT Id FROM Question__c].size());
    }

}