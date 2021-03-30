({
    doInit : function (component, event, helper) {
        helper.loadPicklists(component)
    },
    
    updateSelectedAssociate : function(component, event, helper) {
        
		let selectedAssociate = component.find("associatePicklist").get("v.value")
        component.set("v.selectedAssociate", selectedAssociate)
	},
    
    updateSelectedClient : function(component, event, helper) {
    	
        let selectedClient = component.find("clientPicklist").get("v.value")      
        component.set("v.selectedClient", selectedClient)
	},
    
    addAssociate : function(component, event, helper) {
        // Add Associate to the Board by updating the Client__c
        // field of the Associate.
        helper.linkAssociateToClient(component)
        
        // Afterward, reset the picklists.
        helper.loadPicklists(component)
        
        // Reset stored values for Associate.
        component.set("v.selectedAssociate", "")
        component.find("associatePicklist").set("v.value", "")
        
        // Reset stored values for Client.
        component.set("v.selectedClient", "")
        component.find("clientPicklist").set("v.value", "")

    }
})