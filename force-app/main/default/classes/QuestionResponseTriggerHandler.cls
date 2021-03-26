public class QuestionResponseTriggerHandler {
    public static void cascadeDelete(List<Question_Response__c> responses) {
        List<Question_Response_Rating__c> ratings = [SELECT Question_Response__c FROM Question_Response_Rating__c WHERE Question_Response__c IN : responses];
        delete ratings;
    }
}