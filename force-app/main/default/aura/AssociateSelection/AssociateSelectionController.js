({
    doInit : function (component, event, helper) {
        helper.loadPicklists(component)
    },
    
    updateSelectedAssociate : function(component, event, helper) {
        
		let selectedAssociate = component.find("associatePicklist").get("v.value")
        component.set("v.selectedAssociate", selectedAssociate)
        
        console.log('Selected associate: ' + component.get("v.selectedAssociate"))
	},
    
    updateSelectedClient : function(component, event, helper) {
    	
        let selectedClient = component.find("clientPicklist").get("v.value")      
        component.set("v.selectedClient", selectedClient)
        
        console.log('Selected client: ' + component.get("v.selectedClient"))
	},
    
    addAssociate : function(component, event, helper) {
        helper.linkAssociateToClient(component)        
    }
})