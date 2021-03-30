@isTest
private class CongratulationsBoardControllerTest {
    
    @isTest
    private static void getAssociatesListTest() {
        // Get the Record Types. 1st value is the (Contact) Associate record type; 2nd is the 
        // (Account) Client record type.
        List<RecordType> recordTypeList = CongratulationsBoardController.getRecordTypes();
        
        // Make test Client Accounts. 
        List<Account> clientList = new List<Account>();
        for (Integer index = 0; index < 21; index++) {
            clientList.add(new Account(Name = 'Client ' + index, RecordTypeId = recordTypeList[1].Id)); 
        }
        
        // Make a Client Account for testing negatives later.
        clientList.add(new Account(Name = 'Client 21', RecordTypeId = recordTypeList[1].Id));
        
        insert clientList;
        
        
        List<Contact> associateList = new List<Contact>();

        // Find the correct start and end dates for Associates to be displayed.
        Date correctStartDate = Date.today().addDays(-7);
        Date correctEndDate = Date.today();
        
        // Make test Associates. The first 7 are before the correct range of dates, the 
        // middle 8 are in it, and the last 6 are after it.
        for (Integer index = 0; index < 21; index++) {

            Date selectedDate = correctStartDate.addDays(index - 7);
            // For simplicity, Associate 1 will go with Client 1, etc.
            associateList.add(new Contact(FirstName = 'Associate', LastName = String.valueOf(index), 
                                        RecordTypeId = recordTypeList[0].Id,
                                        Client__c = clientList[index].Id,
                                        Date_Selected__c = selectedDate)); 
        }
        
        /* This isn't possible now that the Client__c field is limited declaratively to 
         * Client Record Types.
        // Make an Associate with a normal account (for testing negatives)  
        associateList.add(new Contact(FirstName = 'Associate', LastName = String.valueOf(20), 
                                      RecordTypeId = recordTypeList[0].Id,
                                      Client__c = clientList[20].Id,
                                      Date_Selected__c = Date.today()));
        */
        
        // Make a normal Contact with a Client account (for testing negatives)
        associateList.add(new Contact(FirstName = 'Associate', LastName = String.valueOf(21), 
                                      Client__c = clientList[21].Id,
                                      Date_Selected__c = Date.today()));
               
        insert associateList;
        
        // Now that the Clients and Associates are in the database,
        // call the getAssociateList method.
        List<CongratulationsBoardController.AssociateClientWrapper> wrapperList 
            									= CongratulationsBoardController.getAssociateList();
        
        // The wrapperList should have a size of 8. (It should not include the Associate
        // with a normal account or the normal Contact with a Client Account.)
        System.assert(wrapperList.size() == 8, 'Wrapper List size (Should be 8): ' + wrapperList.size());
        
        // Make sure Associate n is associated with Client n and that the Associates' 
        // selection dates are in the proper range.
        for (Integer index = 7; index < 15; index++) {
            CongratulationsBoardController.AssociateClientWrapper wrapper = wrapperList[index - 7]; 
            System.assert(wrapper.associateName == 'Associate ' + index);
            System.assert(wrapper.clientName == 'Client ' + index);
            System.assert(wrapper.dateSelected >= correctStartDate && wrapper.dateSelected <= correctEndDate);
            System.debug('Associate Name: ' + wrapper.associateName + ' Client Name: ' +
                         wrapper.clientName + ' Date Selected: ' + wrapper.dateSelected);
        }
        System.debug('Today is: ' + Date.today() + ' 1 week ago was: ' + Date.today().addDays(-7));
    }
    
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