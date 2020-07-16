public with sharing class MeetingAssignmentController {



    /**getMeeting ***********************************************************************************/
    /** */
    @AuraEnabled
    /*
    getMeetings- Return a list of meetings based on component drop down entries
    parameters:
    batch-- represents the dropdown input for batch; will be a selected entry 
    participant-- represents the dropdown input for participant; will be an entry
    based upon the dropdown list populated per batch selection value; CAN BE EMPTY STRING
    */ 
    public static List<Meeting__c> getMeetings(String batch, String participant){
        //escape entries to confirm security (in the event someone attempts a custom entry)
    batch = String.escapeSingleQuotes(batch);
    participant = String.escapeSingleQuotes(participant);
        List<Meeting__c> meetingList = new List<Meeting__c>();
     //   System.debug(batch +  ', '+ participant);
    if (participant == '')
    {
        //If no participant, collect all batch meetings by record type
        Recordtype interviewBatchMeeting = [SELECT ID, Name FROM RecordType WHERE SobjectType='Meeting__c' AND Name='Interview Batch' LIMIT 1];
        Recordtype interventionBatchMeeting = [SELECT ID, Name FROM RecordType WHERE SobjectType='Meeting__c' AND Name='Intervention Batch' LIMIT 1];

        meetingList = [SELECT Id, Name, RecordTypeId, Batch__r.Name, Location__c, Notes__c, Feedback__c, Scheduled__c, Completed__c FROM Meeting__c
                      WHERE Batch__r.Name=:batch AND ( RecordTypeId = :interviewBatchMeeting.Id OR RecordTypeId = :interventionBatchMeeting.Id)];
      //Need to adjust so it works based on selected batch?//add RecordTypeId to queries for meetingList when testing
    }
    else 
    {
        //If participant is selected, find participants by contact name and batch name
        Contact batchPerson = [SELECT Name, Id FROM Contact WHERE Name =:participant AND Account.Name=:batch LIMIT 1];
        List<Meeting_Participant__c> meetingParticipant = [SELECT Id, Name, Meeting__c FROM Meeting_Participant__c 
                                                           WHERE Participant__r.Name =:batchPerson.Name];
        List<ID> meetingIds = new List<ID>();
        //Iterate through each participant returned, add meeting reference to ID set
        for (Meeting_Participant__c MP: meetingParticipant)
        {
            meetingIds.add(MP.Meeting__c);
        }
        //Gather meetings against meeting Ids in the return participant set
        meetingList = [SELECT Id, Name, RecordTypeId, Location__c, Notes__c, Feedback__c, Scheduled__c, Completed__c FROM Meeting__c
                      WHERE Id IN :meetingIds];
        //add RecordTypeId to select for meetingList when testing
        
    }     //return meeting object list
        return meetingList;
        }/**End getMeeting */
    


    /**getBatch *************************************************************************************/
    /** */
    @AuraEnabled
    /*
    getBatchNames- gather all available batches for dropdown propagation
    no parameters
     */
    public static List<String> getBatchNames(){
        List<String> batchNames = new List<String>();
        batchNames.add('Please select a batch before searching...');
        //find the Batch Account record type
      RecordType batchRT = [SELECT ID, Name FROM RecordType WHERE sObjectType='Account' AND Name='Batch' LIMIT 1];
      //query for Batch Account names 
    List<Account> batchAccounts = new List<Account>([SELECT Name FROM Account WHERE RecordTypeID = :batchRT.Id]);
      //  System.debug(batchAccounts);
      //For each batch account, add the name to the string list
      for (Account a: batchAccounts)
       {
           batchNames.add(a.Name);
       }
       //return string list
    return batchNames;
    }/**End getBatch */
        


    /**getAssociates **********************************************************************************/
    /** */
    @AuraEnabled   
    /*
    getAssociates- propagate a list of associates' names based on current batch selection
    parameters:
    batchName--component dropdown selection representing the name of a batch
    */
    public static List<String> getAssociates(String batchName){ 
        //find all contacts associated with the named batch
        List<Contact> assocs = new List<Contact>([SELECT Name, Id FROM Contact WHERE Account.Name =:batchName]);
      //  System.debug('Associates: '+assocs);
        List<String> aNames = new List<String>();
        //add empty string parameter to return list as first option
        aNames.add(''); 

        // for each contact associated with the batch, add the contact name to the return list
        for (Contact assoc : assocs)
        {
            aNames.add(assoc.Name);
        }
      //  System.debug(aNames);
      //return string list
        return aNames;
    }/**End getAssociates */
}