({
	loadAssociateList : function(component) {
		let action = component.get("c.getAssociateList")
        
        action.setCallback(this, function(response) {    
            if (response.getState() === 'SUCCESS') {
                let associateList = response.getReturnValue()
                component.set("v.associateList", associateList)
            }
            else {
                console.log(response.getState())
            }
        })
        
        $A.enqueueAction(action)
        
	}
})