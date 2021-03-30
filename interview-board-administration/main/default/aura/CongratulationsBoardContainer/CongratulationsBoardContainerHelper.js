({
	loadAssociateList : function(component) {
		let action = component.get("c.getAssociateList")
        
        action.setCallback(this, function(response) {    
            if (response.getState() === 'SUCCESS') {
                let associateList = response.getReturnValue()
                let congratulationsBoard = component.find("congratsBoard")
                congratulationsBoard.set("v.associateList", associateList)
            }
            else {
                console.log(response.getState())
            }
        })
        
        $A.enqueueAction(action)
        
	}
})