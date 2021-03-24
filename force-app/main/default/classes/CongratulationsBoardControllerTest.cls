@isTest
private class CongratulationsBoardControllerTest {
    
    @isTest
    private static void getAssociatesListTest() {
        // Get the Record Types. 1st value is the (Contact) Associate record type; 2nd is the 
        // (Account) Client record type.
        List<RecordType> recordTypeList = CongratulationsBoardController.getRecordTypes();
        
        // Make test Client Accounts. 
        List<Account> clientList = new List<Account>();
        for (Integer index = 0; index < 13; index++) {
            clientList.add(new Account(Name = 'Client ' + index, RecordTypeId = recordTypeList[1].Id)); 
        }
        
        // Make a normal Account and another Client Account for testing negatives later.
        clientList.add(new Account(Name = 'Client 13'));
        clientList.add(new Account(Name = 'Client 14', RecordTypeId = recordTypeList[1].Id));
        
        insert clientList;
        
        
        List<Contact> associateList = new List<Contact>();

        // Make test Associates. Have first 7 selected in the previous week, 
        // so they shouldn't be displayed in the wrapperList. The last 6 should.
        Date mostRecentMonday = Date.today().toStartOfWeek().addDays(1);
        for (Integer index = 0; index < 13; index++) {

            Date selectedDate = mostRecentMonday.addDays(index - 7);
            // For simplicity, Associate 1 will go with Client 1, etc.
            associateList.add(new Contact(FirstName = 'Associate', LastName = String.valueOf(index), 
                                        RecordTypeId = recordTypeList[0].Id,
                                        Client__c = clientList[index].Id,
                                        Date_Selected__c = selectedDate)); 
        }
        
        // Make an Associate with a normal account (for testing negatives)  
        associateList.add(new Contact(FirstName = 'Associate', LastName = String.valueOf(13), 
                                      RecordTypeId = recordTypeList[0].Id,
                                      Client__c = clientList[13].Id,
                                      Date_Selected__c = mostRecentMonday));
        
        // Make a normal Contact with a Client account (for testing negatives)
        associateList.add(new Contact(FirstName = 'Associate', LastName = String.valueOf(14), 
                                      Client__c = clientList[14].Id,
                                      Date_Selected__c = mostRecentMonday));
               
        insert associateList;
        
        // Now that the Clients and Associates are in the database,
        // call the getAssociateList method.
        List<CongratulationsBoardController.AssociateClientWrapper> wrapperList 
            									= CongratulationsBoardController.getAssociateList();
        
        // The wrapperList should have a size of 6. (It should not include the Associate
        // with a normal account or the normal Contact with a Client Account.)
        System.assert(wrapperList.size() == 6, 'Wrapper List size (Should be 6): ' + wrapperList.size());
        
        // Make sure Associate n is associated with Client n and thatthere are only 
        // Associates who have been selected since the most recent Monday.
        for (Integer index = 7; index < 13; index++) {
            CongratulationsBoardController.AssociateClientWrapper wrapper = wrapperList[index - 7]; 
            System.assert(wrapper.associateName == 'Associate ' + index);
            System.assert(wrapper.clientName == 'Client ' + index);
            System.assert(wrapper.dateSelected >= mostRecentMonday);
        }
    }
	
    @isTest
    private static void getMostRecentMondayTest() {
        // We have a known Monday, 2021/03/29.
        Date knownMonday = Date.newInstance(2021, 03, 29);
            
        // Make sure that on the 29th and for each of the next 6 days (Mon-Sun), the 
        // method returns a value of 2021/03/29. 
        for (Integer daysAfterMonday = 0; daysAfterMonday < 7; daysAfterMonday++) {
            Date inputDate = knownMonday.addDays(daysAfterMonday);
            Date returnedDate = CongratulationsBoardController.getMostRecentMonday(inputDate);
            System.debug('Date: ' + inputDate + ' Most Recent Monday (Should be 2021/03/29): ' + returnedDate);
            System.assertEquals(knownMonday, returnedDate);
        }
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