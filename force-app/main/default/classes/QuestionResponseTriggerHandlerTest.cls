@isTest
public class QuestionResponseTriggerHandlerTest {
    @isTest
    public static void testDeletion() {
        Question__c question = new Question__c(Body__c='Test Question', Stack__c='Salesforce',
                                               Type__c='Soft Skills');
        Question_Response__c response = new Question_Response__c(Body__c='Test Response', Question__c=question.Id);
        Question_Response_Rating__c rating = new Question_Response_Rating__c(Question_Response__c=response.Id, Rating__c='1');
        
        insert question;
        insert response;
        insert (new Question_Response_Rating__c(Question_Response__c=response.Id, Rating__c='1'));
        insert (new Question_Response_Rating__c(Question_Response__c=response.Id, Rating__c='1'));
        delete response;
        
        List<Question_Response__c> responses = [SELECT Id FROM Question_Response__c WHERE Question__c =: question.Id];
        List<Question_Response_Rating__c> ratings = [SELECT Id FROM Question_Response_Rating__c WHERE Question_Response__c =: response.Id];
        
        System.assertEquals(True, responses.isEmpty(), 'The response was not deleted');
        System.assertEquals(True, ratings.isEmpty(), 'The ratings were not deleted');
    }
}