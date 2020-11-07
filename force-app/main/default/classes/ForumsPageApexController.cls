public class ForumsPageApexController {

    
    @auraEnabled
    public static List<Question__c> getQuestionList(String categoryName, String subCatName) {
        List<Question__c> query = [SELECT Name, Stack__c, Type__c, Body__c FROM Question__c WHERE Stack__c =: categoryName AND Type__c =: subCatName];
        return query;
    }
    
    @auraEnabled
    public static List<Question__c> getRelatedQuestions(String categoryName, String subCatName, String rejectedId) {
        List<Question__c> query = [SELECT Name, Stack__c, Type__c, Body__c FROM Question__c WHERE (Stack__c =: categoryName AND Type__c =: subCatName) AND Name !=: rejectedId];
        return query;
    }
}