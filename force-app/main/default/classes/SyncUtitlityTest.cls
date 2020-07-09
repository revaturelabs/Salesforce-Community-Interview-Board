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
    private static void testGetAssociates() {
        syncUtilityClass SUC = new syncUtilityClass();
        Test.setMock(HttpCalloutMock.class, new SyncCalloutMock());
        
        Test.startTest();
        Contact[] contacts = SUC.getAssociates();
        Test.stopTest();
        
        //System.debug( 'size: '+ contacts.size() + 'contacts: ' + contacts );
        System.assertEquals(10, contacts.size());
    }
    
    //method to test getBatches() in SyncUtilityClass
    @isTest
    private static void testGetBatches() {
        syncUtilityClass SUC = new syncUtilityClass();
        Test.setMock(HttpCalloutMock.class, new SyncCalloutMock());

        Test.startTest();
        Account[] accounts = SUC.getBatches();
        Test.stopTest();

        //System.debug( 'size: '+ accounts.size() + 'contacts: ' + accounts );
        System.assertEquals(2, accounts.size());
    }

    //method to test compareContacts() in SyncUtilityClass
    @isTest
    private static void testCompareContacts(){
        syncUtilityClass SUC = new syncUtilityClass();
        //Generate test data 
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

        //Call the method
        List<Contact> result = SUC.compareContacts(contactList1, contactList2);

        //Check the result list
        System.assertEquals(1, result.size());
        System.assertEquals('SF-3234', result[0].SalesforceId__c);
        System.assertEquals('Someemail3@email.com', result[0].email);
    }

    //Method to test compareBatches() in SyncUtilityClass
    @isTest
    private static void testCompareBatches(){
        syncUtilityClass SUC = new syncUtilityClass();
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
}