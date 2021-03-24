@isTest
private class CongratulationsBoardControllerTest {
    /* INCOMPLETE TEST
    @isTest
    private static void getAssociatesListTest() {
        // Get the Record Types. 1st value is the (Contact) Associate record type; 2nd is the 
        // (Account) Client record type.
        List<RecordType> recordTypeList = CongratulationsBoardController.getRecordTypes();
        
        // Make test Client Accounts
        List<Account> accountList = new List<Account>();
        for (Integer index = 0; index < 20; index++) {
            accountList.add(new Account(Name = 'Account ' + index, RecordTypeId = recordTypeList[1].Id)); 
        }
        insert accountList;
        
        // Make test Associates
        List<Contact> contactList = new List<Contact>();
        for (Integer index = 0; index < 7; index++) {
            Date selectedDate = Date.Today();
            selectedDate = selectedDate.addDays(index);
            contactList.add(new Contact(FirstName = 'Associate', LastName = String.valueOf(index), 
                                        RecordTypeId = recordTypeList[0].Id,
                                        Client__c = accountList[index].Id
                                        Date_Selected__c = )); 
        }
        insert contactList;
    }
	*/
    
	@isTest
    private static void wrapperTest() {
        // Create a test Contact and associated test Account.
        Account testAccount = new Account(Name = 'Account 1');
        insert testAccount;
        Date currentDate = Date.today();
        Contact testContact = new Contact(FirstName = 'Contact', LastName = 'One', AccountId = testAccount.Id, Date_Selected__c = currentDate);
        insert testContact;
        
        // Query for the newly created contact so the Name field is
        // correctly populated.
        Contact queriedTestContact = [SELECT Name, Date_Selected__c, Id FROM Contact LIMIT 1];
        testContact = queriedTestContact;
        
        // Create a wrapper from the Contact and test account name.
        CongratulationsBoardController.AssociateClientWrapper testWrapper = new CongratulationsBoardController.AssociateClientWrapper(testContact, testAccount.Name);
        
		// Check if the wrapper has the correct information.
		System.assertEquals('Account 1', testWrapper.clientName);
        System.assertEquals(currentDate, testWrapper.dateSelected);
        System.assertEquals(testContact.Id, testWrapper.associateId);
        System.assertEquals('Contact One', testWrapper.associateName);
    }
    
    @isTest
    private static void getRecordTypesTest() {
        List<RecordType> RecordTypeList = CongratulationsBoardController.getRecordTypes();
        
        // 1st entry should be the Associate Record Type for the Contact object. 
        // 2nd entry should be the Client Record Type for the Account object.
        System.assertEquals('Associate', RecordTypeList[0].Name);
        System.assertEquals('Contact', RecordTypeList[0].SObjectType);
        System.assertEquals('Client', RecordTypeList[1].Name);
        System.assertEquals('Account', RecordTypeList[1].SObjectType);
    }
    
}