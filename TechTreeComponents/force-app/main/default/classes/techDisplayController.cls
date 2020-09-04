public class techDisplayController {
    @AuraEnabled
    public static List<Primary_Tech__c> getTech(){
        return [SELECT Name, Id FROM Primary_Tech__c];
    }
}
