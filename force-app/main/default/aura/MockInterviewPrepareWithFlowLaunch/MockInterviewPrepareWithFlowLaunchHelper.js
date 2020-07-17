({
    fetchmeetingsHelper : function(component, event, helper) {
       //calls the apex method that returns the filtered query of mock interviewws that match up to this user
        var action = component.get("c.GetFutureMockInterviews");
        
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
    },
    
    launchflow : function(component, event, helper) {
    	//launches the flow 
    		var meetid= event.target.id;
			console.log(meetid);			
        	var flow = component.find("MockInterviewFlow");
        
        //Put input variable values
        var inputVariables = [
            {
                name : "meetingid",
                type : "String",
                value : meetid
            }
        ];
        
        //Reference flow's Unique Name
        flow.startFlow("Mock_Interview_Flow", inputVariables);
    
	},
    
    flowstatuschange : function (component, event, helper) {
        //called when the flow status changes
     if (event.getParam('status') === "FINISHED_SCREEN" || event.getParam('status') === "FINISHED") {
            //runs when the flow is finished, to close the window
           
            $A.get("e.force:closeQuickAction").fire();
            $A.get('e.force:refreshView').fire();
        }
	}
})