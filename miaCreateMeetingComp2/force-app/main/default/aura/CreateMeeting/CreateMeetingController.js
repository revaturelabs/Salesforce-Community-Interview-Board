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
            //do something
        });

        
        $A.enqueueAction(action);
    },

    //Called when Batch picklist is changed
    updateAssociates : function(component, event, helper) {
        
        

    },

    //FIRE EVENT, THROWMEETING
})
