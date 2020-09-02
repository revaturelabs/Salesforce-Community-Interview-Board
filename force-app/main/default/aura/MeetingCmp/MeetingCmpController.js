({
    // Makes callout to apex controller 'MeetingController' to get boolean return value
	doInit : function(component, event, helper) {
        helper.getMeetingId(component, event);
        let timeslotEvent = component.get("CreateTimeSlotEvent");
        timeslotEvent.fire();
		let getPerm = component.get("c.getProfilePerm");  
        getPerm.setCallback(this, function(response){
            if(response.getState() === "SUCCESS") {
            component.set("v.AdminPerm", response.getReturnValue());
            }
            });
        
       $A.enqueueAction(getPerm); 
	},
    
    confirmTrue : function(component){
        let confTrue = true;
        component.set("v.confirmIsTrue", confTrue);
        
    }
    
})