public class primaryTechButtonController {
    @AuraEnabled
    public static List<Sub_Tech__c> subList(String primeId){
        system.debug(primeId);
        primeId = (String)JSON.deserializeUntyped(primeId);
        return [SELECT Name, Id FROM Sub_Tech__c WHERE Primary_Tech__c = :primeId];
    }
}