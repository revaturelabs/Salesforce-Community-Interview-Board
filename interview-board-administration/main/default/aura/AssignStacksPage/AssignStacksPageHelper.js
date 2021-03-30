({
    assignMethod : function(component) {
        console.log("entered assign method helper");
        var stacks = component.get("v.StacksSelected");
        var assocID = component.get("v.AssoKey");
        var action = component.get("c.SetUserStack");
        console.log(stacks + " " + assocID);
        action.setParams({sList: stacks,
                          aID: assocID.Id});
        action.setCallback(this, function(response) { 
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.Notification","Stack has been Assigned to Associate");
            } else {
                console.log( response.getError());
            }
        });
        $A.enqueueAction(action);
	},
    assignMethodBatch : function(component) {
        console.log("entered batch assign method helper");
        var stacks = component.get("v.StacksSelected");
        var batchID = component.get("v.BatKey");
        var action = component.get("c.SetBatchStack");
        console.log(stacks + " " + batchID);
        action.setParams({sList: stacks,
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