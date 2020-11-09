public class responseController {
    
    @AuraEnabled
    public static String getQuestion(String questionID){
        //String questionId = [SELECT Name From Question__c LIMIT 1].Name;
        //System.debug(questionId);
        String randomQuestion = [SELECT Name, Body__c From Question__c WHERE Name =: questionID LIMIT 1].Body__c;
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
    public static void rateResponse(String name, Integer rating){
       Question_Response__c qr = [SELECT id, Total_Votes__c, Upvotes__c FROM Question_Response__c WHERE Name =: name LIMIT 1 ];
       Question_Response_Rating__c[] qrrs = [SELECT id, Rating__c FROM Question_Response_Rating__c WHERE Question_Response__c =: qr.Id];
       Question_Response_Rating__c qrr;
        if(qrrs.size() > 0){
           qrr = qrrs[0]; 
        } else {
           qrr = new Question_Response_Rating__c();
           qrr.Question_Response__c = qr.Id;
        }
        System.debug(qrr);
        if((rating == 1 && qrr.Rating__c == '1') || (rating == -1 && qrr.Rating__c == '-1')){
            delete qrr;
        } else {
            if(rating > 0){
                qrr.Rating__c = '1';
            } else {
                qrr.Rating__c = '-1';
            }
            upsert qrr;
        }
    }
    
    @AuraEnabled
    public static List<Question_Response_Rating__c> getUserVotes(){
        return [SELECT Name, Question_Response__r.Name, Rating__c FROM Question_Response_Rating__c WHERE CreatedById =: UserInfo.getUserId()];
    }
    
    @AuraEnabled
    public static List<Question_Response__c> getResponse(String questionBody){
         id question = [SELECT id FROM Question__c WHERE Body__c =: questionBody LIMIT 1 ].id;
        
        List<Question_Response__c> responseList = [SELECT Name, Body__c, CreatedBy.Name, CreatedDate, Upvotes__c, Total_Votes__c FROM Question_Response__c WHERE Question__c=:question ORDER By Total_Rating__c DESC];
        System.debug(responseList);
        return responseList;
        
    }
    
    

}