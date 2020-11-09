@isTest
public class QuestionPoolApexControllerTest {
    @TestSetup
    static void makeData(){
        List<Question__c> allQuestions = new List<Question__c>();
        List<Question_Response__c> allResponses = new List<Question_Response__c>();
        Question__c question;
        for (Integer i= 0; i<300; i++) {
            String Qname = 'Test Question ' + i;
            allQuestions.add(new Question__c( Body__c = Qname, Stack__c='Salesforce',Type__c='Apex', Locked__c = false));
        }
        insert allQuestions;
        
        //add responses
        for(Integer i=0; i<300; i++){
            String respBody = 'Test Response ' + i;
            allResponses.add(new Question_Response__c( Body__c = respBody, Question__c=allQuestions[i].Id, Upvotes__c=i) );
        }
        insert allResponses;
    }

    @isTest
    public static void getQuestionPoolPositiveTest() {
        List<Question__c> qList = QuestionPoolApexController.getQuestionPool();
        System.assertEquals(300, qList.size());
    }

    @isTest
    public static void deleteQuestionsPositiveTest() {
        Question__c question = [SELECT Id FROM Question__c WHERE Body__c='Test Question 37'];
        String qId = question.Id;
        System.assertEquals(300, [SELECT Id FROM Question__c].size());
        QuestionPoolApexController.deleteQuestions(new List<String>{qId});
        System.assertEquals(299, [SELECT Id FROM Question__c].size());
    }

    @isTest
    public static void deleteQuestionsNegative2DeletesTest() {
        Question__c question = [SELECT Id FROM Question__c WHERE Body__c='Test Question 58'];
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
        List<Question__c> questions = [SELECT Id FROM Question__c WHERE Body__c IN :questionNames];
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
        List<Question__c> questions = [SELECT Id FROM Question__c WHERE Body__c IN :questionNames];
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
   
    //getting responses
    @isTest
    public static void getResponsesPositiveTest() {
        List<Question__c> ques = [SELECT id FROM Question__c];
        List<id> ids = new List<id>();
        
        for(Question__c q : ques){
            ids.add(q.Id);
        }
        
        List<Question_Response__c> rList = QuestionPoolApexController.getResponses(ids);
        System.assertEquals(300, rList.size());
    }
    
    //deleting responses
	@isTest
    public static void deleteResponsesPositiveTest() {
        List<Question_Response__c> response = [SELECT Id FROM Question_Response__c WHERE Upvotes__c = 27];
        //get ids from query
        List<id> ids = new List<id>();
        
        for(Question_Response__c r : response){
            ids.add(r.Id);
        }
        
        System.assertEquals(300, [SELECT Id FROM Question_Response__c].size());
        QuestionPoolApexController.deleteResponses(ids);
        System.assertEquals(299, [SELECT Id FROM Question_Response__c].size());
    }
    
    //lock responses
    @isTest
    public static void lockQuestionsPositiveTest() {
        //get ids
        List<Question__c> ques = [SELECT id, Locked__c FROM Question__c];
        List<id> ids = new List<id>();
        
        for(Question__c q : ques){
            ids.add(q.Id);
        }
        
        //lock and check
        QuestionPoolApexController.lockQuestions(ids);
        //requery
        ques = [SELECT id, Locked__c FROM Question__c];
        
        for(Question__c q : ques){
            System.assertEquals( true, q.Locked__c );
        }
        
        //unlock and check
        QuestionPoolApexController.lockQuestions(ids);
        //requery
        ques = [SELECT id, Locked__c FROM Question__c];
        
        for(Question__c q : ques){
            System.assertEquals( false, q.Locked__c );
        }
    }
}