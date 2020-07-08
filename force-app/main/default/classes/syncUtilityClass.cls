/*
This class synchronizes between the external API (Caliber) and the internal Database
Items Synced are Associate Contacts, Client Contacts, Batch Accounts, and Client Accouts
*/

public with sharing class syncUtilityClass {
    //Declare reused Variables
    String baseUrl = 'http://34.82.182.44/mock/training';
    Contact[] internalAssociates = [SELECT Id, Name, Email, SalesforceId__c, batchId__c, FirstName, LastName FROM Contact WHERE recordType.Name IN ('Associate')];
    Contact[] externalAssociates = new Contact[]{};
    Account[] internalBatches = [SELECT BatchId__c FROM Account WHERE recordType.Name IN ('Batch')];
    Account[] externalBatches = new Account[]{};
        
    Http protocol = new Http();
    HttpRequest request = new HttpRequest();
    
    // Get external associate data
    public Contact[] getAssociates() {
        Contact[] externalData = new Contact[]{};
        request.setMethod('GET');
        // Loop through batch account records
        for(Account batch : [SELECT Id, BatchId__c FROM Account WHERE recordType.Name IN ('Batch')]) {
            // Set batchId as parameters for request
            request.setEndpoint(baseUrl + '/associate?batch=' + batch.BatchId__c);
            HttpResponse response = protocol.send(request);
                
            if(response.getStatusCode() == 200){
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
                                                     AccountId = batch.Id,
                                                     email = (String)contactInfo.get('email'),
                                                     SalesforceId__c = (String)contactInfo.get('salesforceId'),
                                                     RecordTypeId = recordTypeId);
                    externalData.add(newContact);
                }
                
            }
        }
        return externalData;
    }
    
    private Date formatDate(String dateToParse) {
        String year = dateToParse.substring(0, dateToParse.indexOf('-')); //xxxx -xx-xx
        String monthDate = dateToParse.substring(dateToParse.indexOf('-') + 1);
        String regex = '-';
        monthDate = monthDate.replaceAll(regex, '/');
        
        return Date.parse(monthDate + '/' + year);
    } 
    
    //Get the external Batches to compare them against the ones already in the internal DB
    public Account[] getBatches() {
        request.setEndpoint(baseUrl + '/batch');
        request.setMethod('GET');
        HttpResponse response = protocol.send(request);
        
        Account[] externalData = new Account[]{};
            
            if(response.getStatusCode() == 200){
                //Convert the JSON response into something we can work with
                Object[] responseList = (Object[]) JSON.deserializeUntyped(response.getBody());
                
                //Get the record type ID so that we can assign it
                Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Batch').getRecordTypeId();
                
                //Iterate through the list in the response
                for(Object data : responseList) {
                    Map<String, Object> accountInfo = (Map<String,Object>) data;
                    
                    // Get batch trainer information
                    Map<String, Object> trainerInfo = new Map<String,Object>();
                    List<Object> employeeInfo = (List<Object>) accountInfo.get('employeeAssignments');
                    for(Object employee : employeeInfo) {
                        Map<String, Object> employeeMap = (Map<String,Object>) employee;
                        if(employeeMap.get('role') == 'ROLE_LEAD_TRAINER') {
                            trainerInfo = (Map<String, Object>) employeeMap.get('employee');
                        }
                    }
                    
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
                    externalData.add(newAccount);
                }
            }
        return externalData;
    }
    
    //Method to compare 2 lists of Contacts and return a list of the ones missing
    //  If an item from list #1 is not contained in list #2, it will be added
    //  This will return all items that would need to be added to list #2
    private Contact[] compareContacts(Contact[] listOuter, Contact[] listInner) {
        Contact[] associatesToAdd = new Contact[]{};
            
            //Iterate through list #1, and compare each item against all the items in list #2 
            //  to see if list#2 is missing anything, and if so, add it to the list of items to add
            for(Contact first : listOuter) {
                Boolean match = false;
                for(Contact second : listInner) {
                    if(first.SalesforceId__c == second.SalesforceId__c || first.email == second.email) {
                        match = true;
                    }
                }
                if(!match) {
                    associatesToAdd.add(first);
                }
            }
        //Return the list of items to add
        System.debug(associatesToAdd);
        return associatesToAdd;
    }
    
    // This method compares 2 lists of Accounts
    //  If any records are missing from list #2, they will be returned in a new list
    private Account[] compareBatches(Account[] listOuter, Account[] listInner) {
        Account[] batchesToAdd = new Account[]{};
            Boolean match = false;
        
        //Iterate through list #1 and check each item against every item in list #2 
        for(Account first : listOuter) {
            for(Account second : listInner) {
                if(first.batchId__c == second.batchId__c) {
                    match = true;
                }
            }
            if(!match) {
                batchesToAdd.add(first);
            }
        }
        //Return the list of every item that list #2 didn't have
        return batchesToAdd;
    }
    
    //Method to update Associate Contacts and Batch Accounts in Caliber and internal DB
    public void updateDatabases() {
        // Get external data
        externalBatches = getBatches();
        Account[] externalBatchesToAdd = compareBatches(externalBatches, internalBatches);
        insert externalBatchesToAdd;
        
        externalAssociates = getAssociates();
        Contact[] externalAssociatesToAdd = compareContacts(externalAssociates, internalAssociates);
        upsert externalAssociatesToAdd;
        
        // Update Caliber database 
        /*
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        
        Contact[] internalAssociatesToAdd = compareContacts(internalAssociates, externalAssociates);
        request.setEndpoint(baseUrl + '/associate');
        
        Map<String, Object> contactData = new Map<String, Object>();
        contactData.put('flag', null);
        contactData.put('trainingStatus', 'Training Status');
        
        for(Contact newExternal : internalAssociatesToAdd) {
            System.debug(newExternal);
            contactData.put('batchId', newExternal.batchId__c);
            contactData.put('email', newExternal.email);
            contactData.put('id', newExternal.name);
            contactData.put('name', newExternal.firstName + ' ' + newExternal.lastName);
            
            String parsedObject = JSON.serialize(contactData);
            
            request.setBody(parsedObject);
            HttpResponse response = protocol.send(request);
            
            //Check to confirm we got the correct response
            if(response.getStatusCode() == 201) {
                System.debug('External Associate created successfully!');
            } else {
                System.debug(response.getStatusCode());
                System.debug(response.getBody());
            }
        }*/
    }
}