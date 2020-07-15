public class MockInterviewQuestionPoolController {
      @AuraEnabled
        public static List<Interview_Question__c> getQuestionPool(String parentid){
                      return [SELECT id,Name, Question__r.Name, Question__r.Type__c, Question__r.Stack__c, Question__r.Body__c FROM Interview_Question__c WHERE Meeting_md__c = : parentid];
            
        }
    
    	@AuraEnabled
    public static void deleteQuestions(Id[] idList){
        Interview_Question__c[] questionList = [SELECT Id FROM Interview_Question__c WHERE Id IN :idList];
        delete questionList;
    }
        
}