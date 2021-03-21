public without sharing class AssociateSelectionController {
	
    @AuraEnabled
    public static List<Contact> getAssociateList() {
        // We only want Contacts of the Associate record type. So,
        // query for that record type.
        RecordType associateRecordType = [SELECT Id, Name FROM RecordType 
                                          WHERE (SObjectType='Contact' AND Name='Associate') 
                                          LIMIT 1];
        
        // Query for Contacts, filtering by record type id.
        List<Contact> associateList = [SELECT Name 
                                       FROM Contact 
                                       WHERE RecordTypeId=:associateRecordType.Id];
        
        return associateList;
    }
}