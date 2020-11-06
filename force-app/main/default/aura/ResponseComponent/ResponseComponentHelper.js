({
	getResponse : function(component, event, helper){
        let action = component.get("c.getResponse");
        let question = component.get("v.question");
        action.setParams({questionBody:question});
        action.setCallback(this, function(response){
            var name = response.getState();
            if (name === "SUCCESS") {
                component.set("v.responses", response.getReturnValue());
           			}	
    })
        
     		$A.enqueueAction(action);
    },
})