({
	loadPicklists : function(component) {
        let action = component.get('c.getPicklistLists')
        action.setCallback(this, function(response) {
            
            // The action returns a list of lists. The 1st list
            // is for the Select Associate picklist. The 2nd
            // is for the Select Client picklist.
            if (response.getState() == 'SUCCESS') {
                let associateList = response.getReturnValue()[0]
    			component.set("v.associateList", associateList) 
                
                let clientList = response.getReturnValue()[1]
                component.set("v.clientList", clientList)
            }
            else {
                console.log(response.getState())
                console.log(response.getError())
            }
        })
        
        $A.enqueueAction(action)
        
	},
    
    linkAssociateToClient : function(component) {
        let associateId = component.get("v.selectedAssociate")
        let clientId = component.get("v.selectedClient")
        
        if ( !(associateId === "") && !(clientId === "") ) {
            
            let action = component.get("c.linkAssociateToClient")
            action.setParams({associateId : associateId, clientId : clientId})
            action.setCallback(this, function(response) {
                if (response.getState() == 'SUCCESS') {
                    console.log('linkAssociateToClient action succeeded.')
                    
                    // Have a popup notify the user of success
                    let toast = $A.get("e.force:showToast")
                    toast.setParams({"title" : "Congratulations!",
                        			"message" : "A New Associate Has Been Selected!",
                                    "type" : "success"})
                    toast.fire()
                    
                    // Fire event to refresh board.
                    let refreshEvent = component.getEvent("addedAssociate")
                    refreshEvent.fire()
                    
                }
                else {
                    console.log(response.getState())
                    console.log(response.getError())
                }
            })
            
            $A.enqueueAction(action)
            
        }
        else {          
            console.log('Either the client or associate has not been selected.')
            
            // If either the associate or client value is null, notify
            // the user.
            let toast = $A.get("e.force:showToast")
            toast.setParams({"title" : "Error!",
                             "message" : "Both an Associate and a Client must be selected.",
                             "type" : "error"})
            toast.fire()
        }
        
    }
})