({
    fetchmeetingsHelper : function(component, event, helper) {
        var action = component.get("c.GetUpcomingMeetingsAll");
        action.setCallback(this, function(response){
            var state = response.getState();
           if (state === "SUCCESS") {
               console.log('SUCCESS')
                var rows = response.getReturnValue();
                   rows.forEach(function(rows){
                    rows.linkName = '/'+rows.Id;
                });
                console.log(rows)
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
    },
})