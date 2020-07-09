({
    fetchmeetingsHelper : function(component, event, helper) {
       
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
     if (event.getParam('status') === "FINISHED_SCREEN" || event.getParam('status') === "FINISHED") {
            
           
            $A.get("e.force:closeQuickAction").fire();
            $A.get('e.force:refreshView').fire();
        }
	}
})