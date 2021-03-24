public class CongratulationsBoardController {
	
    @AuraEnabled
    public static List<AssociateClientWrapper> getAssociateList() {
        // Query for the Associate and Client record types for
        // the Contact and Account, respectively.
        List<RecordType> RecordTypeList = [SELECT Id, Name FROM RecordType
                                      WHERE ( (SObjectType='Contact' AND Name='Associate')
                                          OR (SObjectType='Account' AND Name='Client') ) 
                                      LIMIT 2];
        System.debug('RecordTypeList: ' + RecordTypeList);
        
        // Identify which record type is which.
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
        
        System.debug('associateRecordType: ' + associateRecordType);
        System.debug('clientRecordType: ' + clientRecordType);
        
        
        // Query for all Associates.
        List<Contact> associateList = [SELECT Name, Account.Name, Account.RecordTypeId, Date_Selected__c
                                       FROM Contact 
                                       WHERE (RecordTypeId=:associateRecordType.Id
                                              /*AND Account.RecordTypeId=:batchRecordType.Id*/
                                              /*AND Account.RecordTypeId=:clientRecordType.Id*/)];
        
        System.debug('AssociateList: ' + associateList);
        List<AssociateClientWrapper> wrapperList = new List<AssociateClientWrapper>();
        
        for (Contact associate : associateList) {
            wrapperList.add(new AssociateClientWrapper(associate, associate.Account.Name));
        }
        
        System.debug('WrapperList: ' + wrapperList);
                
        return wrapperList;  
    }
    
    /* The lightning data table cannot display fields form a parent object
	* directly. Workaround: use a Wrapper Class!! */
    public class AssociateClientWrapper {
        @AuraEnabled public Id associateId {get; set;}
        @AuraEnabled public String associateName {get; set;}
        @AuraEnabled public String clientName {get; set;}
        @AuraEnabled public Date dateSelected {get; set;}
        
        public AssociateClientWrapper(Contact associate, String clientName) {
            this.associateId = associate.Id;
            this.associateName = associate.Name;
            this.clientName = clientName;
            this.dateSelected = associate.Date_Selected__c;
        } 
    }
}