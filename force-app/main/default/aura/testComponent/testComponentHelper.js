({
    simulateServerRequest : function(component) {
        console.log('in loadClientAccounts');
        var action = component.get("c.getClientAccounts");
        action.setCallback(this, function(response){
            if (response.getState() == "SUCCESS"){
                //Set clientAccounts in the view to a list of all Client Accounts retrieved from controller
                console.log('Return Value is ' + response.getReturnValue());
                //componenet.set("v.clientAccounts", response.getReturnValue());
            }

        })
        $A.enqueueAction(action);
    }
});