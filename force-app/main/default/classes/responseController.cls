public class responseController {
    
    @AuraEnabled
    public static String getQuestion(){
        String questionId = [SELECT Name From Question__c LIMIT 1 ].Name;
        System.debug(questionId);
        String randomQuestion = [SELECT Body__c From Question__c LIMIT 1 ].Body__c;
        return randomQuestion;
        
    }
    
    
    @AuraEnabled
    public static void addResponse(String body, String questionBody){
       Question__c q = [SELECT id FROM Question__c WHERE Body__c =: questionBody LIMIT 1 ];
        id test = q.id;
        Question_Response__c newResponse= new Question_Response__c();
        newResponse.Body__c = body;
        
        newResponse.Question__c=test;
        insert(newResponse);
    }
    
    @AuraEnabled
    public static List<Question_Response__c> getResponse(String questionBody){
         id question = [SELECT id FROM Question__c WHERE Body__c =: questionBody LIMIT 1 ].id;
        
        List<Question_Response__c> responseList = [SELECT Body__c, CreatedBy.Name, CreatedDate FROM Question_Response__c WHERE Question__c=:question];
        System.debug(responseList);
        return responseList;
        
    }
    
    

}