public class MockInterviewQuestionPoolController {
      @AuraEnabled
        public static List<Interview_Question__c> getQuestionPool(String parentid){
            //performs filtering logic based on parent record id held in parentid, returns matching records.
                      return [SELECT id, Question__r.Name, Question__r.Type__c, Question__r.Stack__c, Question__r.Body__c FROM Interview_Question__c WHERE Meeting_md__c = : parentid];
            
        }
    
    	@AuraEnabled
    public static void deleteQuestions(Id[] idList){
        //queries for records matching the list of ids selected on the aura component. 
        Interview_Question__c[] questionList = [SELECT Id FROM Interview_Question__c WHERE Id IN :idList];
        //deletes queried records, note this is querying/deleting the interview question junction object, not the actual questions themselves.
        //this removes them from the mock interview, but doesnt delete the actual question__c record containing the actual information.  
        delete questionList;
    }
        
}