public with sharing class syncUtilityClass {
    
    String baseUrl = 'http://34.82.182.44/mock/training';
    Contact[] internalAssociates = [SELECT Id, Name, Email FROM Contact WHERE recordType.Name IN ('Associate')];
    Contact[] externalAssociates = new Contact[]{};
    Account[] internalBatches = [SELECT BatchId__c FROM Account WHERE recordType.Name IN ('Batch')];
    Account[] externalBatches = new Account[]{};

    Http protocol = new Http();
    HttpRequest request = new HttpRequest();

    // Get external associate data
    public Contact[] getAssociates() {
		request.setEndpoint(baseUrl + '/associate');
		request.setMethod('GET');
        HttpResponse response = protocol.send(request);

        Contact[] externalData = new Contact[]{};

		if(response.getStatusCode() == 200){
            // Associate data parsing
            Object[] responseList = (Object[]) JSON.deserializeUntyped(response.getBody());

            Id recordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Associate').getRecordTypeId();
            // Add each associate
            for(Object data : responseList) {
                Map<String, Object> contactInfo = (Map<String,Object>) data;
                Contact newContact = new Contact( firstName = (String)contactInfo.get('firstName'),
                                                    lastName = (String) contactInfo.get('lastName'),
                                                    email = (String)contactInfo.get('email'),
                                                    salesforceId__c = (String)contactInfo.get('salesforceId'),
                                                    RecordTypeId = recordTypeId);
                externalData.add(newContact);
            }
            
        }

        return externalData;
    }

    public Account[] getBatches() {
        request.setEndpoint(baseUrl + '/batch');
		request.setMethod('GET');
        HttpResponse response = protocol.send(request);
        
        Account[] externalData = new Account[]{};

		if(response.getStatusCode() == 200){
            Object[] responseList = (Object[]) JSON.deserializeUntyped(response.getBody());

            Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Batch').getRecordTypeId();
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
                
                // Get batch information
                Account newAccount = new Account( name = (String)accountInfo.get('name'),
                                                    BatchId__c = (String)accountInfo.get('batchId'),
                                                    startDate__c = Date.parse((String)accountInfo.get('startDate')),
                                                    endDate__c = Date.parse((String)accountInfo.get('endDate')),
                                                    location__c = (String)accountInfo.get('location'),
                                                    Type = (String)accountInfo.get('type'),
                                                    passingGrade__c = (Integer)accountInfo.get('passingGrade'),
                                                    goodGrade__c = (Integer)accountInfo.get('goodGrade'),
                                                    currentWeek__c = (Integer)accountInfo.get('currentWeek'),
                                                    RecordTypeId = recordTypeId);
                externalData.add(newAccount);
            }
        }
        return externalData;
    }

    private Contact[] compareContacts(Contact[] listOuter, Contact[] listInner) {
        Contact[] associatesToAdd = new Contact[]{};
        Boolean match = false;
        
        for(Contact first : listOuter) {
            for(Contact second : listInner) {
                if(first.name == second.name || first.email == second.email) {
                    match = true;
                }
            }
            if(!match) {
                associatesToAdd.add(first);
            }
        }

        return associatesToAdd;
    }

    private Account[] compareBatches(Account[] listOuter, Account[] listInner) {
        Account[] batchesToAdd = new Account[]{};
        Boolean match = false;
        
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

        return batchesToAdd;
    }

    public void updateDatabases() {
        // Get external data
        externalAssociates = getAssociates();
        externalBatches = getBatches();
        
        // Update Saleforce database
        Contact[] externalAssociatesToAdd = compareContacts(externalAssociates, internalAssociates);
        insert externalAssociatesToAdd;

        Account[] externalBatchesToAdd = compareBatches(externalBatches, internalBatches);
        insert externalBatchesToAdd;

        // Update Caliber database 
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');

        Contact[] internalAssociatesToAdd = compareContacts(internalAssociates, externalAssociates);
        request.setEndpoint(baseUrl + '/associate');
        
        Map<String, Object> contactData = new Map<String, Object>();
        contactData.put('flag', null);
        contactData.put('trainingStatus', 'Training Status');

        for(Contact newExternal : internalAssociatesToAdd) {
            contactData.put('batchId', newExternal.batchId__c);
            contactData.put('email', newExternal.email);
            contactData.put('id', newExternal.name);
            contactData.put('name', newExternal.firstName + ' ' + newExternal.lastName);

            String parsedObject = JSON.serialize(contactData);

            request.setBody(parsedObject);
            HttpResponse response = protocol.send(request);

            if(response.getStatusCode() == 201) {
                System.debug('External Associate created successfully!');
            } else {
                System.debug(response.getStatusCode());
                System.debug(response.getBody());
            }
        }
    }
}