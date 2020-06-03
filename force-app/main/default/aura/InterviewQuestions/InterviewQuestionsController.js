({
	doInit : function(component, event, helper) {
        //on init, get all the meetings 
        var action = component.get("c.getMeetings");
        
        action.setCallback(this, function(response) {
            if(response.getState()==="SUCCESS")
                component.set("v.meetings", response.getReturnValue());
        });
        
        $A.enqueueAction(action);
		
    },
    //changing questions based on the meeting
    changeMeeting : function(component, event, helper) {
        var value = event.getSource().get("v.value");
        if (value) {
            var action = component.get("c.getQuestions"); 
            action.setParams({"meetingId": value});
            action.setCallback(this, function(response) {
                if(response.getState() === "SUCCESS") {
                    component.set("v.offset", 0);
                    component.set("v.questions", response.getReturnValue());
                    helper.setButtons(component);
                }
            });

            $A.enqueueAction(action);
        }
    },
    
    //pagination management
    prevPage : function(component, event, helper) {
        component.set("v.offset", component.get("v.offset") - component.get("v.limit"));
        helper.setButtons(component);
    },
    
    nextPage : function(component, event, helper) {
        component.set("v.offset", component.get("v.offset") + component.get("v.limit"));
        helper.setButtons(component);
    },
})