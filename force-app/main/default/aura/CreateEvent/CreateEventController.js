({
	meet : function(component, event, helper) {
        
        let getMyMeet = component.get('{!c.getEvent}');
        getMyMeet.setCallback(this, function(response) {
        
        console.log('meet');
            console.log(response.getReturnValue());
        let meetID = response.getReturnValue();
            
        
        window.open(meetID);
        });

        $A.enqueueAction(getMyMeet);
	},
    
    event : function(component) {
        
        var action = component.get('{!c.createEvent}');
        
        $A.enqueueAction(action);
        
        
	}
})