({
    doInit : function(component, event, helper) {
    	let isAdmin = component.get("c.isAdmin")   
        component.set("v.isAdmin", isAdmin)
    },
    
	refreshCongratsBoard : function(component, event, helper) {
		helper.loadAssociateList(component)
	}
})