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
                Contact newContact = new Contact( firstName = contactInfo.get('firstName'),
                                                    lastName = contactInfo.get('lastName'),
                                                    email = contactInfo.get('email'),
                                                    name = contactInfo.get('salesforceId'),
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
        
        Object contactData = new Object(
            batchId = '',
            email = '',
            flag = null,
            id = '',
            name = '',
            trainingStatus = ''
        );
        for(Contact newExternal : internalAssociatesToAdd) {
            contactData.batchId = newExternal.batchId;
            contactData.email = newExternal.email;
            contactData.id = newExternal.name;
            contactData.name = newExternal.firstName + ' ' + newExternal.lastName;
            contactData.trainingStatus = newExternal.trainingStatus;

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
