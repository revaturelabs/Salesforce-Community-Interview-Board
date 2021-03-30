public without sharing class AssociateSelectionController {
	
    public static List<RecordType> getRecordTypes() {
        // Query for the Associate record type of the Contact object.
        List<RecordType> RecordTypeList = [SELECT Id, Name, SObjectType FROM RecordType 
                                           WHERE (SObjectType = 'Contact' AND Name = 'Associate')
                                          		OR (SObjectType = 'Account' AND Name = 'Client')
                                           LIMIT 2];
        
        // Find out which record type is which.
        RecordType associateRecordType;
        RecordType clientRecordType;
        if (RecordTypeList[0].Name == 'Associate') {
            associateRecordType = RecordTypeList[0];
            clientRecordType = RecordTypeList[1];
        }
        else {
            clientRecordType = RecordTypeList[0];
            associateRecordType = RecordTypeList[1];
        }
        
        // Return a list such that the 1st record is always the
        // Associate Record Type and the 2nd is always the Client.
        List<RecordType> newRecordTypeList = new List<RecordType>();
        newRecordTypeList.add(associateRecordType);
        newRecordTypeList.add(clientRecordType);
        
		return newRecordTypeList;
    }
    
    @AuraEnabled
    public static List<List<SObject>> getPicklistLists() {
        
		// Get the Record Types. 1st value is the (Contact) Associate record type; 2nd is the 
        // (Account) Client record type.
        List<RecordType> recordTypeList = getRecordTypes();
        
        // Query for Contacts, filtering by the Associate record type id.
        // Exclude Associates who have already been selected.
        List<Contact> associateList = [SELECT Name, Client__c FROM Contact 
                                       WHERE (RecordTypeId = :recordTypeList[0].Id
                                              AND Client__c = null)];
        
        // Query for Accounts, filtering by the Client record type id.
        List<Account> clientList = [SELECT Name FROM Account
                                    WHERE RecordTypeId = :recordTypeList[1].Id];
        
        
        // Return the two lists. Associate list is 1st, Client list is 2nd.
        return new List<List<SObject>> {associateList, clientList};
        
    }
    
    @AuraEnabled
    public static Boolean linkAssociateToClient(Id associateId, Id clientId) {

        // Boolean indicates success/failure of insert
        Boolean successfulUpdate = true;
        
        // Query for the Associate
        Contact associate = [SELECT Id, Client__c FROM Contact 
                             WHERE (Id = :associateId) LIMIT 1];
        
        // Set the associate's Client__c field to the Client passed into the
        // function. Return a boolean indicating if the update succeeded.
        try {
        	associate.Client__c = clientId;
        	update associate;
        } catch (Exception e) {
            System.debug(e.getStackTraceString());
            successfulUpdate = false;
        }

        return successfulUpdate;
        
    }
    
}