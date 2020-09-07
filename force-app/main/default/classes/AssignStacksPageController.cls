public class AssignStacksPageController {

	@auraenabled
    public static List<contact> AssociateSearch(String AName){
        AName = String.isBlank(AName) ? '%%' : AName + '%';
        list<contact> Associates = [SELECT Id, Name FROM Contact WHERE Name like :AName];
        return Associates;
    }
    
    @AuraEnabled
    public static List<Stack__c> StackSearch(String SName){
        SName = String.isBlank(SName) ? '%%' : SName + '%';
        List<Stack__c> Stacks = [SELECT Id, Name FROM Stack__c WHERE Name like :SName];
        return Stacks;
    }
    
    @AuraEnabled
    public static void SetUserStack(String sID, String aID){
        User assignUser = [SELECT id FROM User WHERE ContactId = :aID LIMIT 1];
        User_Stack__c us = new User_Stack__c();
        us.User__c = assignUser.id;
        us.Stack__c = sID;
        insert us;
    }
}