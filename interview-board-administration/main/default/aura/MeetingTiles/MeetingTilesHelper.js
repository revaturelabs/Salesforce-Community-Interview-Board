({ 
  updateMeetings : function(component) {
    var action = component.get("c.updateMeetings");
    var meeting = component.get("v.Meeting"); 
    action.setParams({updateMeeting:meeting}); 
    $A.enqueueAction(action);
  }
})