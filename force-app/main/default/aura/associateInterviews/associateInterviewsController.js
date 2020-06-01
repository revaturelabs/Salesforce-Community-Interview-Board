({
	init: function(component, event, helper) {
		component.set("v.columns", [
			{
				label: "Meeting Name",
				fieldName: "Name",
				type: "String"
			},
            {
				label: "Interviewer",
				fieldName: "Client_Name__c",
				type: "String"
			},
			{
				label: "Completion Date",
				fieldName: "Completed_Date__c",
				type: "date"
			}
		]);
		
	},
    handleEvent : function(cmp, event, helper) {
        var id = event.getParam("AId");
    	var action = cmp.get("c.getMeetings");
        action.setParams({AId: id});
		action.setCallback(this, $A.getCallback(function (response) {
			if (response.getState() === "SUCCESS") {
				cmp.set("v.meetings", response.getReturnValue());
			} else {
				console.error(response.getError());
			}
		}));
		$A.enqueueAction(action);
    }
})