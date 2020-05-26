({
    getMeetings : function(component) {
        var action = component.get("c.getMeetings");
        
        //Set up the callback
        var self = this;
        action.setCallback(this, function(actionResult) {
            var state = actionResult.getState();
            if (component.isValid() && state === "SUCCESS") {
                component.set("v.contacts", actionResult.getReturnValue());
            }            
        });
        $A.enqueueAction(action);
    }
})


