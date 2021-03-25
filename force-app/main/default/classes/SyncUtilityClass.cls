/*
This class synchronizes between the external API (Caliber) and the internal Database
Items Synced are Associate Contacts and Batch Accounts
AND STACKS AND CHALLENGES
*/

public with sharing class SyncUtilityClass {
    //Declare reused Variables
    public String baseUrl = 'https://caliber2-mock.revaturelabs.com:443/';

    private Contact[] internalAssociates = [SELECT Id, Name, Email, SalesforceId__c, batchId__c, FirstName, LastName FROM Contact WHERE recordType.Name IN ('Associate')];
    @TestVisible private List<Contact[]> externalAssociates = new List<Contact[]>();
    private Account[] internalBatches = [SELECT BatchId__c FROM Account WHERE recordType.Name IN ('Batch')];
    @TestVisible private Account[] externalBatches = new Account[]{};
        
    private Date formatDate(String dateToParse) {
        String year = dateToParse.substring(0, dateToParse.indexOf('-')); //xxxx -xx-xx
        String monthDate = dateToParse.substring(dateToParse.indexOf('-') + 1);
        String regex = '-';
        monthDate = monthDate.replaceAll(regex, '/');
        
        return Date.parse(monthDate + '/' + year);
    } 
    
    //Get the external Batches to compare them against the ones already in the internal DB
    public void getData() {
        Http protocol = new Http();
        HttpRequest request = new HttpRequest();
    
        //System.debug('GET DATA');
        request.setEndpoint(baseUrl + 'mock/training/batch');
        request.setMethod('GET');
        HttpResponse response = protocol.send(request);
        
        Account[] externalBatchData = new Account[]{};
        List<Contact[]> externalContactData = new List<Contact[]>();
        
        if(response.getStatusCode() == 200){
            //Convert the JSON response into something we can work with
            //System.debug(response.getBody());
            Object[] responseList = (Object[]) JSON.deserializeUntyped(response.getBody());
            
            //Get the record type ID so that we can assign it
            Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Batch').getRecordTypeId();
            
            //Iterate through the list in the response
            for(Object data : responseList) {
                Map<String, Object> accountInfo = (Map<String,Object>) data;
                
                // Get relevant batch Account information
                Account newAccount = new Account( name = (String)accountInfo.get('name'),
                                                 BatchId__c = (String)accountInfo.get('batchId'),
                                                 startDate__c = formatDate((String)accountInfo.get('startDate')),
                                                 endDate__c = formatDate((String)accountInfo.get('endDate')),
                                                 location__c = (String)accountInfo.get('location'),
                                                 Type = (String)accountInfo.get('type'),
                                                 passingGrade__c = (Integer)accountInfo.get('passingGrade'),
                                                 goodGrade__c = (Integer)accountInfo.get('goodGrade'),
                                                 currentWeek__c = (Integer)accountInfo.get('currentWeek'),
                                                 RecordTypeId = recordTypeId);
                
                //Add the sObjects to the list of Account objects for comparisson later
                externalBatchData.add(newAccount);
            }
        }
        
        for(Account batch : externalBatchData) {
            // Set batchId as parameters for request
            request.setEndpoint(baseUrl + 'mock/training/associate?batch=' + batch.BatchId__c);
            response = protocol.send(request);
            
            Contact[] contactsForBatch = new Contact[]{};
                
                if(response.getStatusCode() == 200){
                    //System.debug('Response was 200');
                    // Associate data parsing
                    Object[] responseList = (Object[]) JSON.deserializeUntyped(response.getBody());
                    
                    //To assign the associate record type id, you have to first get the ID
                    Id recordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Associate').getRecordTypeId();
                    // Add each associate
                    for(Object data : responseList) {
                        Map<String, Object> contactInfo = (Map<String,Object>) data;
                        Contact newContact = new Contact( firstName = (String)contactInfo.get('firstName'),
                                                         lastName = (String) contactInfo.get('lastName'),
                                                         batchId__c = batch.batchId__c,
                                                         email = (String)contactInfo.get('email'),
                                                         SalesforceId__c = (String)contactInfo.get('salesforceId'),
                                                         RecordTypeId = recordTypeId);
                        contactsForBatch.add(newContact);
                    }
                    
                } else {
                    System.debug('response status code was ' + response.getStatusCode());
                }
            externalContactData.add(contactsForBatch);
        }
        
        externalBatches = externalBatchData;
        externalAssociates = externalContactData;
    }
    
    //Method to compare 2 lists of Contacts and return a list of the ones missing
    //  If an item from list #1 is not contained in list #2, it will be added
    //  This will return all items that would need to be added to list #2
    @testVisible
    private Contact[] compareContacts(List<Contact[]> listOuter, Contact[] listInner) {
        Contact[] associatesToAdd = new Contact[]{};
            
            //Iterate through the list of lists
            for(Contact[] currentlList : listOuter) {
                //Iterate through list #1, and compare each item against all the items in list #2 
                //  to see if list#2 is missing anything, and if so, add it to the list of items to add
                for(Contact first : currentlList) {
                    Boolean match = false;
                    for(Contact second : listInner) {
                        if(first.SalesforceId__c == second.SalesforceId__c || first.email == second.email || associatesToAdd.contains(first)) {
                            match = true;
                        }
                    }
                    if(!match) {
                        associatesToAdd.add(first);
                    }
                }    
            }
        //Return the list of items to add
        //System.debug(associatesToAdd);
        return associatesToAdd;
    }
    
    // This method compares 2 lists of Accounts
    //  If any records are missing from list #2, they will be returned in a new list
    @testVisible
    private Account[] compareBatches(Account[] listOuter, Account[] listInner) {
        //System.debug('Inside method compareBatches()');
        Account[] batchesToAdd = new Account[]{};
            Boolean match = false;
        
        //Iterate through list #1 and check each item against every item in list #2 
        for(Account first : listOuter) {
            match = false;
            //System.debug('First: ' + first.name + ': ' + first.BatchId__c);
            for(Account second : listInner) {
                //System.debug('Second: ' + second.name + ': ' + second.BatchId__c);
                if(first.batchId__c == second.batchId__c) {
                    match = true;
                    //System.debug('Match');
                }
            }
            if(!match) {
                //System.debug('Not a match: ' + first.Name);
                batchesToAdd.add(first);
            }
        }
        //Return the list of every item that list #2 didn't have
        //System.debug(batchesToAdd);
        return batchesToAdd;
    }
    
    @testVisible
    private void matchAssociateToBatch(Contact[] associates) {
        Account[] batches = [SELECT Id, BatchId__c FROM Account WHERE recordType.Name IN ('Batch')];
        
        for(Contact associate:associates) {
            for(Account batch : batches) {
                if(associate.BatchId__c == batch.BatchId__c) {
                    associate.AccountId = batch.Id;
                }
            }    
        }
        
    }
    
    //Method to update Associate Contacts and Batch Accounts in Caliber and internal DB
    public List<Integer> updateDatabase() {
        
        List<Integer> updateCounts = new List<Integer>();
        
        //While testing, we cannot make a callout after a DML operation, and so the test will throw a CalloutException
        try {
            // Get external data
            getData();
            Account[] externalBatchesToAdd = compareBatches(externalBatches, internalBatches);
            Contact[] externalAssociatesToAdd = compareContacts(externalAssociates, internalAssociates);
            insert externalBatchesToAdd;
            matchAssociateToBatch(externalAssociatesToAdd);
            insert externalAssociatesToAdd;
            
            // Return number of updates
            updateCounts.add(externalBatchesToAdd.size());
            updateCounts.add(externalAssociatesToAdd.size());
            System.debug(updateCounts);
            
        } catch (exception e) {
            System.debug('An error has occured with Caliber sync.');
            updateCounts.add(-1);
            updateCounts.add(-1);
        }
        return updateCounts;
    }

    /* This function has no arguments and returns a list of "stacks" from the caliber category service */
    public List<Stack__c> getCategories(){
        Http protocol = new Http();
        HttpRequest request = new HttpRequest();
    
        //System.debug('GET DATA');
        request.setEndpoint(baseUrl + 'mock/category/category');
        request.setMethod('GET');
        HttpResponse response = protocol.send(request);

        if(response.getStatusCode() < 200 || response.getStatusCode() >= 300){
            //error
            throw new System.CalloutException('Couldn\'t access caliber category service endpoint.');
        } else {
            //200 range is successful!
            Stack__c[] stacks = new List<Stack__c>();
            for(Object rawobj: (List<Object>) JSON.deserializeUntyped(response.getBody())){
                Map<String,Object> rawstack = (Map<String,Object>) rawobj;
                if((Boolean) rawstack.get('active')){
                    stacks.add(new Stack__c(Name=(String)rawstack.get('skillCategory'), 
                                            CaliberID__c=String.valueOf((Integer)rawstack.get('categoryId'))));
                }
            }
            insert stacks;
            return stacks;
        }
    }
}