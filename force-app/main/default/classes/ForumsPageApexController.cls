public class ForumsPageApexController {

    
    @auraEnabled
    public static List<Question__c> getQuestionList(String categoryName, String subCatName) {
        List<Question__c> query = [SELECT Name, Stack__c, Type__c, Body__c FROM Question__c WHERE Stack__c =: categoryName AND Type__c =: subCatName];
        return query;
    }
}