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
    public static void SetUserStack(List<Stack__c> sList, String aID){
        //UserStack Obj based on junction between user and stack, we grab user based on contact Id and assign it to stack(s)
        User assignUser = [SELECT id FROM User WHERE ContactId = :aID LIMIT 1];
        List<User_Stack__c> usList = new List<User_Stack__c>();
        System.debug('Hello');
        for(Stack__c s : sList){
            System.debug('Hello');
            System.debug(s.Id);
            User_Stack__c us = new User_Stack__c();
            us.User__c = assignUser.id;
            us.Stack__c = s.id;
            usList.add(us);

        }
        insert usList;
    }
}