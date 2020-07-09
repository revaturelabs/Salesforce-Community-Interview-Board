({
    init : function(component, event, helper) {
        helper.fetchmeetingsHelper(component, event, helper);
    },
    
    onstatuschange : function(component, event, helper) {
    	helper.flowstatuschange(component, event, helper);
	},
    
    onflowlaunch : function(component, event, helper) {
    	helper.launchflow(component, event, helper);
	},
    
    onmodalopen : function(component, event, helper) {
        
        component.set("v.isModalOpen", true);
        helper.launchflow(component, event, helper);
    	
	},
      onmodalclose : function(component, event, helper) {
    	component.set("v.isModalOpen", false);
	}
    
})