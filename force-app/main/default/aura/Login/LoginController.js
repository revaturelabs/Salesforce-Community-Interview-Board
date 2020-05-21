({
	 doInit: function(component, event, helper) {
         
         
        component.set("v.userImgBool", false);
        // Create the action
         var output = component.find("output")
        var action = component.get("c.ActiveUser");
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                if( response.getReturnValue() == "Star Wars Bounty Board Site Guest User"){
                     output.set('v.disabled',false);
					 component.set("v.user__name", "Login");
                } else{
                      component.set("v.user__name", response.getReturnValue());
					  output.set('v.disabled', true);
                    helper.handleUserImg(component, event)
                }

            }
            else {
                console.log("Failed with state: " + state);
                component.set("v.user__name", "Login");
				output.set('v.disabled',false);

            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
         
         
    }
   
}
 
)