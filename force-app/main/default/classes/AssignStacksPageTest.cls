@isTest
public class AssignStacksPageTest {
    @TestSetup
    static void makeData(){
        //set Account Portal Owner
        UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
        system.debug('portalRole is ' + portalRole);
        Profile profile1 = [Select Id from Profile where name = 'System Administrator'];
        User portalAccountOwner1 = new User(
        UserRoleId = portalRole.Id,
        ProfileId = profile1.Id,
        Username = System.now().millisecond() + 'test2@test.com',
        Alias = 'batman',
        Email='bruce.wayne@wayneenterprises.com',
        EmailEncodingKey='UTF-8',
        Firstname='Bruce',
        Lastname='Wayne',
        LanguageLocaleKey='en_US',
        LocaleSidKey='en_US',
        TimeZoneSidKey='America/Chicago'
        );
        Database.insert(portalAccountOwner1);

        System.runAs(portalAccountOwner1){
            //create Client
            Account testClient = new Account(Name='Test Client');
            insert testClient;

            //create Batch
            Account testBatch = new Account(Name='Test Batch',
                                                OwnerId = portalAccountOwner1.Id
                                            );
            insert testBatch;

            //create Associate/User
            Profile testProfile = [SELECT Id FROM Profile WHERE Name='Associate'];
            Id testRecordTypeId = [SELECT Id FROM RecordType WHERE Name='Associate' LIMIT 1].Id;
            Contact testAssociate = new Contact(LastName ='UserT',
                                                    RecordTypeId=testRecordTypeId,
                                                    AccountId=testBatch.Id);
            insert testAssociate;
            User testUser = new User(Alias='standt',
                                        Email='testAssignStackuser@testorg.com',
                                        EmailEncodingKey='UTF-8',
                                        LastName='Testing',
                                        LanguageLocaleKey='en_US',
                                        LocaleSidKey='en_US',
                                        ProfileId = testProfile.Id,
                                        Username='testAssignStackuser@testorg.com',
                                        TimeZoneSidKey='America/Los_Angeles',
                                        ContactId=testAssociate.Id
                                    );
            insert testUser;

            //create Stack
            Stack__c testStack = new Stack__c(Name='Test Stack');
            insert testStack;
        }

    }

    @isTest
    static void AssociateSearchTest() {
        List<Contact> returnedAssociates = AssignStacksPageController.AssociateSearch('UserT');
        System.assertNotEquals(null, returnedAssociates, 'There is an issue with the returned associates');
    }

    @isTest
    static void StackSearchTest() {
        List<Stack__c> returnedStacks = AssignStacksPageController.StackSearch('Test Stack');
        System.assertNotEquals(null, returnedStacks, 'There is an issue with the returned stacks');
    }

    @isTest
    static void BatchSearchTest() {
        List<Account> returnedBatch = AssignStacksPageController.BatchSearch('Test Batch');
        System.assertNotEquals(null, returnedBatch, 'There is an issue with the returned batch');
    }

    @isTest
    static void SetUserStackTest() {
        List<Contact> returnedAssociates = AssignStacksPageController.AssociateSearch('UserT');
        List<Stack__c> returnedStacks = AssignStacksPageController.StackSearch('Test Stack');
        AssignStacksPageController.SetUserStack(returnedStacks, returnedAssociates[0].Id);
        List<User_Stack__c> results = [SELECT Id FROM User_Stack__c];
        System.assertNotEquals(null, results, 'There is an issue with the inserted stacks for the user');

    }

    @isTest
    static void SetBatchStackTest() {
        List<Account> returnedBatch = AssignStacksPageController.BatchSearch('Test Batch');
        List<Stack__c> returnedStacks = AssignStacksPageController.StackSearch('Test Stack');
        AssignStacksPageController.SetBatchStack(returnedStacks, returnedBatch[0].Id);
        List<User_Stack__c> results = [SELECT Id FROM User_Stack__c];
        System.assertNotEquals(null, results, 'There is an issue with the inserted stacks for the batch');

    }
}
