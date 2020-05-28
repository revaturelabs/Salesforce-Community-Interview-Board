({
    updateMeetings : function(component) {
        var action = component.get("c.updateMeetings");
        action.setParams("v.Meeting");
        $A.enqueueAction(action);
    }
})


