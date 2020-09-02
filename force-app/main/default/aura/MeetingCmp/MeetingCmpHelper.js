({
	getMeetingId : function(component,event) {
		let meetId = component.get("c.getMeeting");
        
        meetId.setCallback(this, function(response){
            if(response.getState() === "SUCCESS") {
            component.set("v.meetingId", response.getReturnValue());
            }
          
        });
        $A.enqueueAction(meetId);
	}
})