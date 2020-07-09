({
    init : function(component, event, helper) {
        helper.fetchmeetingsHelper(component, event, helper);
    },
    
    onstatuschange : function(component, event, helper) {
    	helper.flowstatuschange(component, event, helper);
	},
    
    onflowlaunch : function(component, event, helper) {
    	helper.launchflow(component, event, helper);
	}
})