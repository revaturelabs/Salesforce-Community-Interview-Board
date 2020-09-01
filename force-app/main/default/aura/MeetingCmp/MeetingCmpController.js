({
    // Makes callout to apex controller 'MeetingController' to get boolean return value
	doInit : function(component, event, helper) {
        helper.getMeetingId(component, event);
		let getPerm = component.get("c.getProfilePerm");  
        getPerm.setCallback(this, function(response){
            if(response.getState() === "SUCCESS") {
            component.set("v.AssociatePerm", response.getReturnValue());
            }
            });
        
       $A.enqueueAction(getPerm); 
	}
    
})