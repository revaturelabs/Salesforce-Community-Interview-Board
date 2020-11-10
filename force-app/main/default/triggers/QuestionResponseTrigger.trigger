trigger QuestionResponseTrigger on Question_Response__c (before delete) {
    // Perform a cascade delete on all ratings associated to a response before
    // it is deleted from the database
    List<Question_Response_Rating__c> ratings = [SELECT Id FROM Question_Response_Rating__c];
    delete ratings;
}