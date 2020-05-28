({
	init: function(component, event, helper) {
		component.set("v.columns", [
			{
				label: "Meeting Name",
				fieldName: "Name",
				type: "String"
			},
			/*
			{
				label: "Associate",
				fieldName: "",
				type: ""
			},
			{
				label: "Interviewer",
				fieldName: "",
				type: ""
			},
			*/
			{
				label: "Date",
				fieldName: "Scheduled__c",
				type: "date"
			}
		]);
	},

	search: function(component, event, helper) {
		let searchCmp = component.find("associateId");
		component.set("v.searchLoading", true);

		var action = component.get("c.associateSearch");
		action.setParams({identifier: component.get("v.associateId")});
		action.setCallback(this, $A.getCallback(function (response) {
			if (response.getState() === "SUCCESS") {
				component.set("v.searchLoading", false);
				component.set("v.meetings", response.getReturnValue());
			} else {
				console.error(response.getError());
			}
		}));
		$A.enqueueAction(action);
	}
})
