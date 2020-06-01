({
    updateMeetings : function(component) {
        var action = component.get("c.updateMeetings");
        action.setParams({updateMeeting : component.get("v.Meeting")});
        $A.enqueueAction(action);
    }
})