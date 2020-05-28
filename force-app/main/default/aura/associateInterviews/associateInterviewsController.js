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
				label: "Completion Date",
				fieldName: "Completed_Date__c",
				type: "date"
			}
		]);
		helper.getMeetings(component);
	}
})
