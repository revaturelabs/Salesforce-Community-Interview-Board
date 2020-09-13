({
    /*getMeetingId : function(component,event) {
        let meetId = component.get("c.getMeeting");

        meetId.setCallback(this, function(response){
            if(response.getState() === "SUCCESS") {
            component.set("v.meetingId", response.getReturnValue());
            }

        });
        $A.enqueueAction(meetId);
    },*/

    getActiveStack : function(component, event) {
         let stackCall = component.get("c.getActiveStacks");

        stackCall.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS") {
                component.set("v.AllStacks", response.getReturnValue());
            } 
        });
        $A.enqueueAction(stackCall);
    }
})