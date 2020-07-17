({
    init : function(component, event, helper) {
        helper.fetchmeetingsHelper(component, event, helper);
    },//init function
    
    onstatuschange : function(component, event, helper) {
    	helper.flowstatuschange(component, event, helper);
	}, //called every time the flow has a status change
    
    onflowlaunch : function(component, event, helper) {
    	helper.launchflow(component, event, helper);
	}, // called to launch the flow
    
    onmodalopen : function(component, event, helper) {
        //called when the modal popup window opens
        component.set("v.isModalOpen", true);
        var MockId = event.target.id;
        var e =$A.get("e.c:FlowLaunch");
        console.log("MockId: " + MockId);
        e.setParams({"MockId" : MockId }); 
        e.fire();
       // helper.launchflow(component, event, helper);
    	
	},
      onmodalclose : function(component, event, helper) {
    	component.set("v.isModalOpen", false);
	}//called when the modal popup window closes
    
})