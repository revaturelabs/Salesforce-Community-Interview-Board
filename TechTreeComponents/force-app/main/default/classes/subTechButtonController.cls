public class subTechButtonController {
    @AuraEnabled
    public static List<Challenge__c> challenges(String curId){
        curId = (String) JSON.deserializeUntyped(curId);
        return [SELECT name,id,sub_tech__c,Details__c,Completed__c,Score__c FROM Challenge__c WHERE sub_tech__c=:curId];
    }
}
