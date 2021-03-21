({
	loadAssociateList : function(component, event) {
        let action = component.get('c.getAssociateList')
        action.setCallback(this, function(response) {
            
            if (response.getState() == 'SUCCESS') {
                let associateList = response.getReturnValue()
    			component.set("v.associateList", associateList) 
            }
            else {
                console.log(response.getState())
                console.log(response.getError())
            }
        })
        $A.enqueueAction(action)
	}
})