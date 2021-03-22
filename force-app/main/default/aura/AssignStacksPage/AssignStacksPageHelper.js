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
	},
    assignMethodBatch : function(component) {
        console.log("entered batch assign method helper");
        var stackID = component.get("v.StaKey");
        var batchID = component.get("v.BatKey");
        var action = component.get("c.SetBatchStack");
        console.log(stackID + " " + batchID);
        action.setParams({sID: stackID,
                          bID: batchID});
        action.setCallback(this, function(response) { 
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.Notification","Stack has been Assigned to Batch");
            }
        });
        $A.enqueueAction(action);
	}
})