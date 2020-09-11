({
    assignMethod : function(component) {
        console.log("entered assign method helper");
        var stackID = component.get("v.StaKey");
        var assocID = component.get("v.AssoKey");
        var action = component.get("c.SetUserStack");
        console.log(stackID + " " + assocID);
        action.setParams({sID: stackID,
                          aID: assocID});
        action.setCallback(this, function(response) { 
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.Notification","Stack has been Assigned to Associate");
            }
        });
        $A.enqueueAction(action);
	}
})