public class CommunityBoardController {
	
    @AuraEnabled
    public static List<Contact> getAssociateList() {
        
        // Maybe have additional checks. (Client__c is actually populated
        // with a client account, etc.)
        List<Contact> associateList = [SELECT Name, Client__r.Name FROM Contact
                          			   WHERE Client__c != null];
        
        return associateList;
        
    }
}