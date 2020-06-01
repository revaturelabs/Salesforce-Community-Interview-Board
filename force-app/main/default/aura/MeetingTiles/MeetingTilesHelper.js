({
    updateMeetings : function(component) {
        var action = component.get("c.updateMeetings");
        var param = component.get("v.Meeting");
        action.setParams("UpdateMeeting" , param);
        $A.enqueueAction(action);
    }
})


