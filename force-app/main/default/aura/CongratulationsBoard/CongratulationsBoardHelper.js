({
	loadAssociateList : function(component, event) {
		let action = component.get("c.getAssociateList")
        action.setCallback(this, function(response) {
            
            if (response.getState() === 'SUCCESS') {
                let associateList = response.getReturnValue()
                console.log('getAssociateList return value: ' + associateList)
                component.set("v.associateList", associateList)
                console.log('associateList componenent value: ' + component.get('v.associateList'))
            }
            else {
                console.log(response.getState())
            }
        })
        $A.enqueueAction(action)
	}
})