public with sharing class QuestionPoolApexController {
        @AuraEnabled
        public static List<Question__c> getQuestionPool(){
            List<Question__c> allQuestions = new List<Question__c>();
            
            for (Question__c q : [SELECT Type__c, Stack__c, Body__c FROM Question__c]) {
                allQuestions.add(q);
                
            }
            return allQuestions;
            
        }
    
    	@AuraEnabled
    public static void deleteQuestions(Id[] idList){
        Question__c[] questionList = [SELECT Id FROM Question__c WHERE Id IN :idList];
        delete questionList;
    }
    
    @auraEnabled
    public static list<Question_Response__c> getResponses(list<id> questionId){
        list<Question_Response__c> questionResult = [SELECT id, Body__c, Upvotes__c FROM Question_Response__c WHERE Question__r.Id IN :questionId];
        
        return 	questionResult;
    }
    
    @AuraEnabled
    public static void deleteResponses(Id[] idList){
        Question_Response__c[] questionResponseList = [SELECT Id FROM Question_Response__c WHERE Id IN :idList];
        delete questionResponseList;
    }
        

}