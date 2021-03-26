public class QuestionResponseRatingTriggerHandler {
    public static void deleteRating(List<Question_Response_Rating__c> ratings) {
        for (Question_Response_Rating__c rating : ratings) {
            Id responseId = rating.Question_Response__c;
            Question_Response__c response = [SELECT Total_Votes__c, Upvotes__c FROM Question_Response__c
                                             WHERE Id =: responseId];
            response.Total_Votes__c--;
            if (rating.Rating__c == '1') {
                response.Upvotes__c--;
            }
            
            update response;
        }
    }
    public static void insertRating(List<Question_Response_Rating__c> ratings) {
        for (Question_Response_Rating__c rating : ratings) {
            Id responseId = rating.Question_Response__c;
            Question_Response__c response = [SELECT Total_Votes__c, Upvotes__c FROM Question_Response__c
                                             WHERE Id =: responseId];
            
            // Update the associated Question_Response__c total votes and number of upvotes fields
            // before the Question_Response_Rating__c is inserted into the database
            response.Total_Votes__c++;
            if (rating.Rating__c == '1') {
                   response.Upvotes__c++;
            }
                
            update response;
        }
    }
    public static void updateRating(List<Question_Response_Rating__c> ratings) {
        for (Question_Response_Rating__c rating : ratings) {
            Id responseId = rating.Question_Response__c;
            Question_Response__c response = [SELECT Total_Votes__c, Upvotes__c FROM Question_Response__c
                                             WHERE Id =: responseId];
        
        if (rating.Rating__c == '-1') {
            response.Upvotes__c -= 1;
        } else {
            response.Upvotes__c += 1;
        }
        
        update response;
        }
    }
}