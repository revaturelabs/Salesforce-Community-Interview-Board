({
    doInit : function(component, event, helper) {
        var action = component.get("c.getAll");
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS")
            {
                var results = response.getReturnValue();
                component.set("v.interviewers", results[0]);
                component.set("v.associates", results[1]);
                component.set("v.batches", results[2]);
                helper.ascMap(component);
            }
        });
        $A.enqueueAction(action);
    },

    clickCreate : function(component, event, helper) {
        var meet = component.get("v.meeting");
        var entireBatch = component.get("v.allbatch");
        var batch = component.get("v.selBatch");
        var interviewer = content.get("v.selInterviewer");
        var associate = null;
        
        if(!entireBatch)
            associate = component.get("v.selAssociate");

        var action = component.get("c.createMeeting");
        
        action.setParams({"meeting":meet,"batch":batch,"interviewer":interviewer,"associate":associate});
        
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS")
            {
                var meeting = response.getReturnValue();
            }
        });

        
        $A.enqueueAction(action);
    },

    //Called when Batch picklist is changed
    updateAssociates : function(component, event, helper) {
        //retrieve all associates, batchAssociate array (to be filled), and the selected Batch Name
        //from the view to reduce the "Associates" picklist to only the names in the selected Batch
        var accid = event.getSource().get("v.value");
        component.set("v.batchAssociates", component.get("v.ascbatchmap")[accid]);
    },

    //whatever component wants this event needs to handle it, probably the meeting tiles or meeting assignment
    throwTheMeeting : function(component, event, helper) {
            var throwMeeting = cmp.getEvent("throwMeeting");
            //throwMeeting.setParams
            //throwMeeting.fire();
    }
})