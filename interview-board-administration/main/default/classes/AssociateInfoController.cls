public with sharing class AssociateInfoController {
    @AuraEnabled
    //still needs to be linked to JS controller that handles button clicks/searches
    public static Contact getContact() {
        return [SELECT Id, Name, AccountId, Title, MobilePhone, Email, MailingAddress 
                FROM Contact 
                LIMIT 1];
    }
}