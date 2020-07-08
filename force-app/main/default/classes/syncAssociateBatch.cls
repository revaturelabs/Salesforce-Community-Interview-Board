public with sharing class syncUtilityClass {
    
    String baseUrl = 'http://34.82.182.44/mock/training';
    Contact[] internalAssociates = [SELECT Id, Name, Email FROM Contact WHERE recordType.Name IN ('Associate')];
    Contact[] externalAssociates = new Contact[]{};

    Http protocol = new Http();
    HttpRequest request = new HttpRequest();

    public void getAssociates() {
		request.setEndpoint(baseUrl + '/associate');
		request.setMethod('GET');
        HttpResponse response = protocol.send(request);
        
		if(response.getStatusCode() == 200){
            Object[] responseList = (Object[]) JSON.deserializeUntyped(response.getBody());
            Contact[] externalData = new Contact[]{};
			for(Object data : responseList) {
                Map<String, Object> contactInfo = (Map<String,Object>) data;
                Contact newContact = new Contact( firstName = (String)contactInfo.get('firstName'),
                                                    lastName = (String) contactInfo.get('lastName'),
                                                    email = (String)contactInfo.get('email'),
                                                    salesforceId__c = (String)contactInfo.get('salesforceId'),
                                                    flag = null);
                externalData.add(newContact);
            }
            
            externalAssociates = externalData;
		}
    }

    public Contact[] compare(Contact[] listOuter, Contact[] listInner) {
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

    public void updateDatabases() {
        getAssociates();
        Contact[] internalAssociatesToAdd = compare(internalAssociates, externalAssociates);
        Contact[] externalAssociatesToAdd = compare(externalAssociates, internalAssociates);

        insert externalAssociatesToAdd;

        request.setEndpoint(baseUrl + '/associate');
        request.setMethod('POST');
        
<<<<<<< HEAD
        Map<String, Object> contactData = new Map<String, Object>();
        contactData.put('flag', null);
        contactData.put('trainingStatus', 'Training Status');

        for(Contact newExternal : internalAssociatesToAdd) {
            contactData.put('batchId', newExternal.batchId);
            contactData.put('email', newExternal.email);
            contactData.put('id', newExternal.name);
            contactData.put('name', newExternal.firstName + " " + newExternal.lastName);
=======
        Object contactData = new Object(
            batchId = '',
            email = '',
            flag = null,
            id = '',
            name = '',
            trainingStatus = 'Training'
        );
        for(Contact newExternal : internalAssociatesToAdd) {
            contactData.batchId = newExternal.batchId__c;
            contactData.email = newExternal.email;
            contactData.id = newExternal.salesforceId__c;
            contactData.name = newExternal.firstName + ' ' + newExternal.lastName;
            contactData.trainingStatus = 'Training';
>>>>>>> 4f4f29faf1994b49138717b1544fddd06a5f7845

            String parsedObject = JSON.serialize(contactData);

            request.setHeader('Content-Type', 'application/json');
            request.setBody(parsedObject);
            HttpResponse response = protocol.send(request);

            if(response.getStatusCode() == '201') {
                System.debug('External Associate created successfully!');
            } else {
                System.debug(response.getStatusCode());
                System.debug(response.getBody());
            }
        }
    }
}
