public class subTechButtonController {
    @AuraEnabled
    public static List<Challenge__c> challenges(String curId){
        curId = (String) JSON.deserializeUntyped(curId);
        return [SELECT name,id,sub_tech__c,Details__c,Score__c FROM Challenge__c WHERE sub_tech__c=:curId];
    }
    
    @AuraEnabled
    public static List<Completion__c> completions(List<Challenge__c> challs){
        //curId = (String) JSON.deserializeUntyped(curId);
        return [SELECT name,id,Completed__C,Challenge__c FROM Completion__c WHERE Challenge__c in :challs];
    }
}