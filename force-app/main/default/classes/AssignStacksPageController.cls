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
    public static List<Account> BatchSearch(String SName){
        SName = String.isBlank(SName) ? '%%' : SName + '%';
        List<Account> Batch = [SELECT Id,BatchId__c, Name FROM Account WHERE Name like :SName];
        return Batch;
    }
    
    @AuraEnabled
    public static void SetUserStack(List<Stack__c> sList, String aID){
        //UserStack Obj based on junction between user and stack, we grab user based on contact Id and assign it to stack(s)
        User assignUser = [SELECT id FROM User WHERE ContactId = :aID LIMIT 1];
        List<User_Stack__c> usList = new List<User_Stack__c>();
        for(Stack__c s : sList){
            System.debug(s.Id);
            User_Stack__c us = new User_Stack__c();
            us.User__c = assignUser.id;
            us.Stack__c = s.id;
            usList.add(us);

        }
        insert usList;
    }
    
    @AuraEnabled
    public static void SetBatchStack(List<Stack__c> sList, String bID){

        //Grab each associate in given batch(bID)
        list<contact> Associates = [SELECT Id, OwnerId FROM Contact WHERE AccountId =: bID];
        		system.debug('Associates:' + Associates);
        //find users of each associate
        list<User> assignUser = [SELECT id,Name FROM User WHERE ContactId =: Associates ];
        		system.debug('assignUser:' + assignUser);
        //Prepare a list for populating (Best Practice)
        list<User_Stack__c> UserStack = new list<User_Stack__c>();
        //assign users given stack(sID) by populating list
        for(User specificUser : assignUser){

            for(Stack__c s : sList){
                User_Stack__c us = new User_Stack__c();
                us.User__c = specificUser.id;
                us.Stack__c = s.id;
                UserStack.add(us);
    
            }
    	}
        system.debug('UserStack:' + UserStack);
        //insert UserStack list into database;
        insert UserStack;
    }
}
