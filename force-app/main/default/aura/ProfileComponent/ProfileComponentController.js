({
	doInit : function(component, event, helper) {
		console.log('inside init');
        helper.Username(component,event);
        helper.AssignedStack(component,event);
        helper.getSubTechScore(component,event);
	}
})