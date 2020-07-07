public with sharing class QuestionPoolApexController {
        @AuraEnabled
        public static List<Question__c> getQuestionPool(){
            List<Question__c> allQuestions = new List<Question__c>();
            
            for (Question__c q : [SELECT Name, Subject__c, Body__c FROM Question__c]) {
                allQuestions.add(q);
                
            }
            return allQuestions;
            
        }
        

}
