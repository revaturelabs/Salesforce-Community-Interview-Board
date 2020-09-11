public with sharing class SessionController {
    @AuraEnabled(cacheable=true)
    
    //return the matching records based on SOQL if the user doesn't enter a search term 
    public static List<Quiz_Session__c> getSessions(String searchKey) {
        if (String.isBlank(searchKey)) {
         
            return [SELECT Id,Date_and_Time__c, Phase__c, Current_Question__r.Id, Current_Question__r.Stack__c  FROM Quiz_Session__c WHERE Date_and_Time__c = TODAY ORDER BY Date_and_Time__c];

    }
    else {
        //return the matching records based on SOQL and the user's search
        String key = '%' + searchKey + '%';
        return [SELECT Id, Date_and_Time__c,Phase__c, Current_Question__r.Id, Current_Question__r.Stack__c  FROM Quiz_Session__c WHERE Phase__c LIKE :key AND Date_and_Time__c = TODAY ORDER BY Date_and_Time__c];
    } 
}
@AuraEnabled(cacheable=true)

//if no records return, notify the user
public static Quiz_Session__c getSession(Id sessionID) {
    List<Quiz_Session__c> sessions = [SELECT Id,Phase__c
    FROM Quiz_Session__c WHERE Date_and_Time__c = TODAY];
  if (sessions.size() != 1) {
    throw new AuraHandledException('Could not find session');
  }
  return sessions[0];
}

}