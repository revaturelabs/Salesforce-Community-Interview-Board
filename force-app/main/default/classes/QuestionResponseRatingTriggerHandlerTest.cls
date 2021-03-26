@isTest
public class QuestionResponseRatingTriggerHandlerTest {
    @isTest
    public static void deleteTest() {
        Question__c question = new Question__c(Body__c='Test Question', Stack__c='Salesforce',
                                               Type__c='Soft Skills');
        Question_Response__c response = new Question_Response__c(Body__c='Test Response', Question__c=question.Id);
        
        insert(question);
        insert(response);
        insert(new Question_Response_Rating__c(Question_Response__c=response.Id, Rating__c='1'));
        
        List<Question_Response_Rating__c> ratings = [SELECT Id, Rating__c FROM Question_Response_Rating__c];
        
        delete(ratings);
        
        List<Question_Response__c> responses = [SELECT Id, Total_Votes__c, Upvotes__c FROM Question_Response__c];
        
        System.assertEquals(0, responses[0].Total_Votes__c, 'The total number of votes was not adjusted correctly');
        System.assertEquals(0, responses[0].Upvotes__c, 'The total number of upvotes was not adjusted correctly');
        
    }
    @isTest
    public static void insertTest() {
        Question__c question = new Question__c(Body__c='Test Question', Stack__c='Salesforce',
                                               Type__c='Soft Skills');
        Question_Response__c response = new Question_Response__c(Body__c='Test Response', Question__c=question.Id);
        
        insert(question);
        insert(response);
        insert(new Question_Response_Rating__c(Question_Response__c=response.Id, Rating__c='1'));
        
        List<Question_Response__c> responses = [SELECT Id, Total_Votes__c, Upvotes__c FROM Question_Response__c];
        
        System.assertEquals(1, responses[0].Total_Votes__c, 'The total number of votes was not adjusted correctly');
        System.assertEquals(1, responses[0].Upvotes__c, 'The total number of upvotes was not adjusted correctly');
    }
    @isTest
    public static void updateTest() {
        Question__c question = new Question__c(Body__c='Test Question', Stack__c='Salesforce',
                                               Type__c='Soft Skills');
        Question_Response__c response = new Question_Response__c(Body__c='Test Response', Question__c=question.Id);
        
        insert(question);
        insert(response);
        insert(new Question_Response_Rating__c(Question_Response__c=response.Id, Rating__c='1'));
        
        List<Question_Response_Rating__c> ratings = [SELECT Id, Rating__c FROM Question_Response_Rating__c];
        
        ratings[0].Rating__c = '-1';
        update(ratings);
        
        List<Question_Response__c> responses = [SELECT Id, Total_Votes__c, Upvotes__c FROM Question_Response__c];
        
        System.assertEquals(1, responses[0].Total_Votes__c, 'The total number of votes was not adjusted correctly');
        System.assertEquals(0, responses[0].Upvotes__c, 'The total number of upvotes was not adjusted correctly');
    }
}