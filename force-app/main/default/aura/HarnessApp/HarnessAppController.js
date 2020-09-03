({
    //All the functions are used to set value for attribute in HARNESSEVENT.evt resource so that we can use that value in other component.
	changeStatusApex : function(component, event, helper) {
		var res=component.get("v.Apexvalue");
       var evt = $A.get("e.c:Harnessevent");
        evt.setParams({ "Pass_Result": res});
        evt.fire();
	},
    
    changeStatusAura : function(component, event, helper) {
		var res=component.get("v.AuraValue");
       var evt = $A.get("e.c:Harnessevent");
        console.log('AuraValue:'+res);
        evt.setParams({ "Pass_Result": res});
        evt.fire();
	},
    
     changeStatusWorkflow : function(component, event, helper) {
		var res=component.get("v.WorkflowValue");
       var evt = $A.get("e.c:Harnessevent");
        console.log('WorkflowValue:'+res);
        evt.setParams({ "Pass_Result": res});
        evt.fire();
	},
    
     changeStatusProcessBuilder : function(component, event, helper) {
		var res=component.get("v.ProcessBuilderValue");
       var evt = $A.get("e.c:Harnessevent");
        console.log('ProcessBuilderValue:'+res);
        evt.setParams({ "Pass_Result": res});
        evt.fire();
	},
})