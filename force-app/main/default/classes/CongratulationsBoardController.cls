public class CongratulationsBoardController {
    
    public static List<RecordType> getRecordTypes() {
        // Query for the Associate and Client record types for
        // the Contact and Account objects, respectively.
        List<RecordType> RecordTypeList = [SELECT Id, SObjectType, Name FROM RecordType
                                      	   WHERE ( (SObjectType='Contact' AND Name='Associate')
                                                  OR (SObjectType='Account' AND Name='Client') ) 
                                      	   LIMIT 2];
        
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
        
        // Return a list such that the 1st record is always the
        // Associate Record Type and the 2nd is always the Client.
        List<RecordType> newRecordTypeList = new List<RecordType>();
        newRecordTypeList.add(associateRecordType);
        newRecordTypeList.add(clientRecordType);
        
		return newRecordTypeList;
    }
    
    public static Date getMostRecentMonday(Date inputDate) {
        // We only want to display associates that have been selected within the last
        // week, starting from the most recent Monday.
        Date mostRecentSunday = inputDate.toStartOfWeek();
        if (inputDate.isSameDay(mostRecentSunday)) {
            mostRecentSunday = mostRecentSunday.addDays(-7);
        }
        Date mostRecentMonday = mostRecentSunday.addDays(1);
        
        return mostRecentMonday;
    }
	
    @AuraEnabled
    public static List<AssociateClientWrapper> getAssociateList() {
		
        // Get the Record Types. 1st value is the (Contact) Associate record type; 2nd is the 
        // (Account) Client record type.
        List<RecordType> recordTypeList = getRecordTypes();
        
		Date mostRecentMonday = getMostRecentMonday(Date.today());
        
        // Query for Associates based off of Date Selected.
        List<Contact> associateList = [SELECT Name, Client__r.Name, Date_Selected__c
                                       FROM Contact 
                                       WHERE (RecordTypeId=:recordTypeList[0].Id
                                              AND Date_Selected__c >= :mostRecentMonday
                                              AND Client__r.RecordTypeId=:recordTypeList[1].Id)];
        
        // Create a list of wrappers to contain the info that will be displayed
        // in the component.
        List<AssociateClientWrapper> wrapperList = new List<AssociateClientWrapper>(); 
        for (Contact associate : associateList) {
            wrapperList.add(new AssociateClientWrapper(associate, associate.Client__r.Name));
        }
                
        return wrapperList;  
    }
    
    // The lightning data table cannot display fields form a parent object
	// directly. This wrapper class gets around that issue.
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