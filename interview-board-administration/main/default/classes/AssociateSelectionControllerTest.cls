@isTest
private class AssociateSelectionControllerTest {
	
    @testSetup
    private static void makeAssociatesAndClients() {
        
        // Get Associate and Client record types
        List<RecordType> RecordTypeList = AssociateSelectionController.getRecordTypes();
        
        // Make 200 Clients (Positive Bulk Test)
        List<Account> clientPositiveTest = new List<Account>();
        for (Integer index = 0; index < 200; index++) {
            clientPositiveTest.add(new Account(Name = 'Client ' + index, RecordTypeId = RecordTypeList[1].Id));
        }    
        insert clientPositiveTest;
        
        List<Account> clientNegativeTest = new List<Account>();
        // Make normal Accounts (Negative Test)
        for (Integer index = 0; index < 50; index++) {
            clientNegativeTest.add(new Account(Name = 'Normal Account ' + index));
        }
        insert clientNegativeTest;

        // Make 200 associates with no clients (Positive Bulk Test)
        List<Contact> associatePositiveTest = new List<Contact>();
        for (Integer index = 0; index < 200; index++) {
            associatePositiveTest.add(new Contact(FirstName = 'Associate', LastName = String.valueOf(index),
                                                  RecordTypeId = RecordTypeList[0].Id));
        }
        insert associatePositiveTest;
        
        // Make 50 associates with a client (Negative Test)
        List<Contact> associateNegativeTest = new List<Contact>();
        for (Integer index = 0; index < 50; index++) {
            associateNegativeTest.add(new Contact(FirstName='Selected Associate', 
                                                                LastName = String.valueOf(index),
                                                                RecordTypeId = RecordTypeList[0].Id,
                                                                Client__c = clientPositiveTest[index].Id));
        }
        insert associateNegativeTest;
        
        // Make 50 normal contacts (Negative Test)
        List<Contact> associateNegativeTest2 = new List<Contact>();
        for (Integer index = 0; index < 50; index++) {
            associateNegativeTest2.add(new Contact(FirstName='Selected Associate', 
                                                                LastName = String.valueOf(index)));
        }
        insert associateNegativeTest2;
        
    }
    
    @isTest 
    private static void getPicklistsTest() {
        
        List<List<SObject>> picklistList = AssociateSelectionController.getPicklistLists();
        
        // Make sure the first list only includes Contacts.
        Schema.SObjectType contactType = Schema.Contact.getSObjectType();
        for (SObject element : picklistList[0]) {
            System.assertEquals(contactType, element.getSObjectType());
        }
        
        // Make sure the first list only includes Accounts.
        Schema.SObjectType accountType = Schema.Account.getSObjectType();
        for (SObject element : picklistList[1]) {
            System.assertEquals(accountType, element.getSObjectType());
        }
        
        // Make sure the list of Associates only includes the 200 good cases.
        System.assertEquals(200, picklistList[0].size());
        
        // Make sure the list of Clients only includes the 200 good cases.
        System.assertEquals(200, picklistList[1].size());
                               
    }
    
    @isTest
    private static void linkAssociateToClientTest() {
        
        // Get Associate and Client record types (Positive Bulk Test)
        List<RecordType> RecordTypeList = AssociateSelectionController.getRecordTypes();
        
        Contact associatePositiveTest = new Contact(FirstName = 'Associate', LastName = '0',
                                                  RecordTypeId = RecordTypeList[0].Id);
        insert associatePositiveTest;
        
        Account clientPositiveTest = new Account(Name = 'Client 1', 
                                                 RecordTypeId = RecordTypeList[1].Id);
        insert clientPositiveTest;

            
        Boolean positiveSuccess = AssociateSelectionController.linkAssociateToClient(
            									associatePositiveTest.Id, clientPositiveTest.Id);
        
        // Make sure the operation succeeded for the positive case.
        System.assertEquals(true, positiveSuccess);
        
        // Make sure the Associate's Client__c field was updated.
        // (This requires the associatePositiveTest to be queried again.)
        associatePositiveTest = [SELECT Client__c FROM Contact 
                                 WHERE Id = :associatePositiveTest.Id];
        System.assertEquals(clientPositiveTest.Id, associatePositiveTest.Client__c);
        
        // Make sure a failed DML operation returns false
        Boolean negativeFail = AssociateSelectionController.linkAssociateToClient(
            									associatePositiveTest.Id, associatePositiveTest.Id);
        System.assertEquals(false, negativeFail);
        
    }
    
    @isTest
    private static void getRecordTypesTest() {
        List<RecordType> RecordTypeList = AssociateSelectionController.getRecordTypes();
        
        // 1st entry should be the Associate Record Type for the Contact object. 
        // 2nd entry should be the Client Record Type for the Account object.
        System.assertEquals('Associate', RecordTypeList[0].Name);
        System.assertEquals('Contact', RecordTypeList[0].SObjectType);
        System.assertEquals('Client', RecordTypeList[1].Name);
        System.assertEquals('Account', RecordTypeList[1].SObjectType);
    }
    
}