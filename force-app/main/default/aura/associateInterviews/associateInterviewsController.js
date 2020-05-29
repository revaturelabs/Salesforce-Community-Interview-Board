({
	init: function(component, event, helper) {
		component.set("v.columns", [
			{
				label: "Meeting Name",
				fieldName: "Name",
				type: "String"
			},
			{
				label: "Interviewer(s)",
				fieldName: "Interviewers",
				type: "String"
			},
			{
				label: "Date",
				fieldName: "Schedule",
				type: "Datetime"
			}
		]);
	},

	search: function(component, event, helper) {
		let searchCmp = component.find("associateId");
		component.set("v.searchLoading", true);

		var action = component.get("c.associateSearch");
		action.setParams({associateId: component.get("v.associateId")});
		action.setCallback(this, $A.getCallback(function (response) {
			component.set("v.searchLoading", false);
			if (response.getState() === "SUCCESS") {
				component.set("v.meetings", response.getReturnValue());
				console.log(response.getReturnValue());
			} else {
				console.error(response.getError());
			}
		}));
		$A.enqueueAction(action);
	}
})
