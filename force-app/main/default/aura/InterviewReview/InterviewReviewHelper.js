({
    fetchMeetingsHelper : function(component, event, helper) {
      
        var action = component.get("c.GetPastInterviews");
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var rows = response.getReturnValue();
              	//console.log(rows);
                component.set("v.data", rows);
                component.set('v.isLoading', false);
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
                component.set('v.isLoading', false);
            }
        });
        $A.enqueueAction(action);
    }/*,
    //Unused functionality to get a list of questions
    getquestionsHelper : function(component, event, helper) {
       var action = component.get("c.GetInterviewQuestions");
        action.SetParams()
        action.setCallback(this, function(response){
            var state = response.getState();
           if (state === "SUCCESS") {
                var rows = response.getReturnValue();
              	console.log(rows);
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
    */
    
})