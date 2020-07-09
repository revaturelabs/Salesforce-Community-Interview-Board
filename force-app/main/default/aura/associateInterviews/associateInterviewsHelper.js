({
    fetchmeetingsHelper : function(component, event, helper) {
        component.set('v.columns', [
                {label: 'Name', fieldName: 'Name', type: 'text'},
            	{label: 'Client Name', fieldName: 'Client_Name__c', type: 'text'},            
            	{label: 'Meeting Status', fieldName: 'Meeting_status__c', type: 'text'},           
            	    {label: 'Scheduled Time', fieldName: 'Scheduled__c', type: 'date', typeAttributes: {
                                                                            day: 'numeric',
                                                                            month: 'short',
                                                                            year: 'numeric',
                                                                            hour: '2-digit',
                                                                            minute: '2-digit',
                                                                            second: '2-digit',
                                                                            hour12: true}},
            {label: 'Location', fieldName: 'location__c', type: 'text'}
              
            ]);
        var action = component.get("c.GetUpcomingMeetings");
        action.setParams({});
        action.setCallback(this, function(response){
            var state = response.getState();
           if (state === "SUCCESS") {
                var rows = response.getReturnValue();
                component.set("v.data", rows);
            } else {
                let errors = response.getError();
                let message = 'Unknown error'; // Default error message
                // Retrieve the error message sent by the server.
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;
                }
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "ERROR!",
                    "message": message, 
                    "type" : 'error'
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    }
})