({
    doInit : function (component, event, helper) {
        let associateList = helper.loadAssociateList(component, event)
    },
    
    updateSelectedAssociate : function(component, event, helper) {
		let selectedAssociate = component.find("v.associatePickList").get("value")
        console.log('Selected Associate: ' + selectedAssociate)
        if (selectedAssociate != null) {
        	component.set("v.selectedAssociate", selectedAssociate)
        	console.log('Selected associate: ' + component.get("v.selectedAssociate"))
        }
        else {
            console.log('No associate selected.')
        }

	}
})