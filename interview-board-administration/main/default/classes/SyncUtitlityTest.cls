/*
    Test class to test SyncUtilityClass.cls methods
*/
@isTest
private class SyncUtitlityTest {
    @TestSetup
    static void makeData(){
        Account[] batches = new Account[]{};
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Batch').getRecordTypeId();
        for(Integer i=0; i<5; i++) {
            batches.add(new Account(name='Test' + i, batchId__c='TR-123' + i, recordTypeId=recordTypeId) );
        }
        insert batches;
    }

    @isTest
    private static void testGetData() {
        SyncUtilityClass SUC = new SyncUtilityClass();
        Test.setMock(HttpCalloutMock.class, new SyncCalloutMock());
        
        Test.startTest();
        SUC.getData();
        Test.stopTest();
        
        //System.debug( 'size: '+ contacts.size() + 'contacts: ' + contacts );
        System.assertEquals(2, SUC.externalAssociates.size());
        System.assertEquals(2, SUC.externalBatches.size());
    }

    //method to test compareContacts() in SyncUtilityClass
    @isTest
    private static void testCompareContacts(){
        SyncUtilityClass SUC = new SyncUtilityClass();
        //Generate test data 
        List<Contact[]> listOfContactLists = new List<Contact[]>();
        Contact[] contactList1 = new Contact[]{
            new Contact(
                lastName='Test1',
                SalesforceId__c='SF-1234',
                email='Someemail1@email.com'
            ),
            new Contact(
                lastName='Test2',
                SalesforceId__c='SF-2234',
                email='Someemail2@email.com'
            ),
            new Contact(
                lastName='Test3',
                SalesforceId__c='SF-3234',
                email='Someemail3@email.com'
            )
        };
        //Added twice to check for duplicate values
        listOfContactLists.add(contactList1);
        listOfContactLists.add(contactList1);
        //System.debug('List of lists: ' + ListOfContactLists);

        Contact[] contactList2 = new Contact[]{
            new Contact(
                lastName='Test1',
                SalesforceId__c='SF-1234',
                email='Someemail1@email.com'
            ),
            new Contact(
                lastName='Test2',
                SalesforceId__c='SF-2234',
                email='Someemail2@email.com'
            ),
            new Contact(
                lastName='Test4',
                SalesforceId__c='SF-4234',
                email='Someemail4@email.com'
            )  
        };
		//System.debug(contactList2);
        
        //Call the method
        List<Contact> result = SUC.compareContacts(listOfContactLists, contactList2);

        System.debug(result);
        //Check the result list, should contain only 1 instance of Test3
        System.assertEquals(1, result.size());
        System.assertEquals('SF-3234', result[0].SalesforceId__c);
        System.assertEquals('Someemail3@email.com', result[0].email);
    }

    @isTest
    private static void testCompareBatches(){
        SyncUtilityClass SUC = new SyncUtilityClass();
        //Generate test data
        Account[] accountList1 = new Account[]{
            new Account(
                Name='TestAccount1',
                BatchId__c='BC-1234'
            ),
            new Account(
                Name='TestAccount2',
                BatchId__c='BC-1234'
            ),
            new Account(
                Name='TestAccount3',
                BatchId__c='BC-1235'
            )
        };
        Account[] accountList2 = new Account[]{
            new Account(
                Name='TestAccount1',
                BatchId__c='BC-1234'
            ),
            new Account(
                Name='TestAccount2',
                BatchId__c='BC-1234'
            ),
            new Account(
                Name='TestAccount4',
                BatchId__c='BC-1236'
            )
        };

        //Run method
        Account[] result = SUC.compareBatches(accountList1, accountList2);

        //Test resulting List
        System.assertEquals(1, result.size());
        System.assertEquals('TestAccount3', result[0].Name);
        System.assertEquals('BC-1235', result[0].BatchId__c);
    }

    @isTest
    private static void testMatchAssociateToBatch(){
        SyncUtilityClass SUC = new SyncUtilityClass();

        //Generate test data
        Contact[] contactList = new Contact[]{
            new Contact(
                lastName='Test1',
                SalesforceId__c='SF-1234',
                email='Someemail1@email.com',
                batchId__c='TR-1231'
            ),
            new Contact(
                lastName='Test2',
                SalesforceId__c='SF-2234',
                email='Someemail2@email.com',
                batchId__c='TR-1231'
            ),
            new Contact(
                lastName='Test4',
                SalesforceId__c='SF-4234',
                email='Someemail4@email.com',
                batchId__c='TR-1238'
            )
        };
		insert contactList;
        
        System.debug('Contact List' + contactList);
        test.startTest();
            SUC.matchAssociateToBatch(contactList);
        test.stopTest();
        
        ID AccountId = [SELECT ID FROM Account WHERE BatchId__c = 'TR-1231'].id;
        
        System.assertEquals(AccountId, contactList[0].AccountId);
        System.assertEquals(AccountId, contactList[1].AccountId);
        System.assertEquals(null, contactList[2].AccountId);
    }

    //Method to test the updateDatabases() method
    @isTest 
    private static void testUpdateDatabase(){
        SyncUtilityClass SUC = new SyncUtilityClass();
        Test.setMock(HttpCalloutMock.class, new SyncCalloutMock());

        List<sObject> toInsert = new List<sObject>();
        Challenge__c achallenge = new Challenge__c(Name='toupdate',CaliberID__c='1658');
        Stack__c astack = new Stack__c(Name='.NET',CaliberID__c='8');
        toInsert.add(achallenge); toInsert.add(astack);
        insert toInsert;
        Completion__c acompletion= new Completion__c(CaliberID__c='5', Challenge__c=achallenge.Id);
        insert acompletion;

        Test.startTest();
        SUC.updateDatabase();
        Test.stopTest();

        Contact[] internalAssociates = [SELECT Id, Name FROM Contact WHERE recordType.Name IN ('Associate')];
        Account[] internalBatches = [SELECT Name, BatchId__c FROM Account WHERE recordType.Name IN ('Batch')];
        Challenge__c[] challenges = [SELECT Id,Name FROM Challenge__c];
        Stack__c[] stacks = [SELECT Id,Name FROM Stack__c];
        Completion__c[] completions = [SELECT Id, Name FROM Completion__c];
        
        //System.debug('Internal Associates: ' + internalAssociates);
        //System.debug('Internal Batches: ' + internalBatches);
        System.assertEquals(4, internalAssociates.size());
        System.assertEquals(7, internalBatches.size());
        System.assertEquals(3, challenges.size());
        System.assertEquals(2, stacks.size());
        System.assertEquals(3, completions.size());
    }

    @isTest
    private static void testGetCategories(){
        SyncUtilityClass SUC = new SyncUtilityClass();
        Test.setMock(HttpCalloutMock.class, new SyncCalloutMock());

        Test.startTest();
        Stack__c[] stacks = SUC.getCategories();
        Test.stopTest();

        System.assertEquals(2,stacks.size());
    }

    @isTest
    private static void testGetAssessments(){
        SyncUtilityClass SUC = new SyncUtilityClass();
        Test.setMock(HttpCalloutMock.class, new SyncCalloutMock());

        Test.startTest();
        Challenge__c[] challenges = SUC.getAssessments([SELECT Id,BatchId__c FROM Account WHERE recordType.Name IN ('Batch')]);
        Test.stopTest();
        
        System.assertEquals(3,challenges.size());
    }
}