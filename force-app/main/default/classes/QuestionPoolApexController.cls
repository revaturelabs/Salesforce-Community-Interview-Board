public with sharing class QuestionPoolApexController {
        @AuraEnabled
        public static List<Question__c> getQuestionPool(){
            //querys the database for the questions
            List<Question__c> allQuestions = new List<Question__c>();
            
            for (Question__c q : [SELECT Type__c, Stack__c, Body__c, Locked__c, Setting__c FROM Question__c]) {
                allQuestions.add(q);
                
            }
            return allQuestions;
            
        }
    
    	@AuraEnabled
    public static void deleteQuestions(Id[] idList){
        //querys the database for specific Id's and deletes the results
        Question__c[] questionList = [SELECT Id FROM Question__c WHERE Id IN :idList];
        delete questionList;
    }
    
    @auraEnabled
    public static list<Question_Response__c> getResponses(list<id> questionId){
        //querys the database for the responses to the provided question Id and returns them
        list<Question_Response__c> questionResult = [SELECT id, Question__c, Body__c, Upvotes__c, Question__r.Body__c FROM Question_Response__c WHERE Question__r.Id IN :questionId];
        return 	questionResult;
    }
    
    @AuraEnabled
    public static void deleteResponses(Id[] idList){
        //querys the database for responses selected by the user by Id and deletes them
        Question_Response__c[] questionResponseList = [SELECT Id FROM Question_Response__c WHERE Id IN :idList];
        delete questionResponseList;
    }
    
    @AuraEnabled
    public static void lockQuestions(Id[] idList){
        //querys the database for selected questions where provided the Id and changes the locked field to be either true or false
		Question__c[] questionList = [SELECT Id, locked__c FROM Question__c WHERE Id IN :idList];
        for(question__c qst: questionList){
            if(qst.locked__c){
               qst.locked__c=false; 
            }else{
                qst.locked__c=true;
            }       
        }
        update questionList;
    }
        

}