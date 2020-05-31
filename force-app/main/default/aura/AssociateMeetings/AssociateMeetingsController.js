({
	// Setup datatable columns
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
        let searchInput = component.find("searchInput").get("v.value");

		// Users must fix errors, other than custom ones, before searching
		if (!searchInput.get("v.validity").valid && !searchInput.get("v.validity").customError) {
			return;
		}

		// Clear custom error status
		searchInput.setCustomValidity("");
		searchInput.reportValidity();
		// Indicate the search bar is loading
		component.set("v.searchLoading", true);

		// Initialize new action
		var action = component.get("c.associateSearch");
		action.setParams({associateId: component.get("v.searchKeyword")});

		action.setCallback(this, $A.getCallback(function (response) {
			// Done loading, remove indicator
			component.set("v.searchLoading", false);
			
			switch (response.getState()) {
				case "SUCCESS":
					// Populate table with values
					component.set("v.meetings", response.getReturnValue());
					break;
				case "ERROR":
					// Clear table on a server error
					component.set("v.meetings", null);
					// Display error message on search bar
					let errors = response.getError();
					if (errors) {
						if (errors[0] && errors[0].message) {
							searchInput.setCustomValidity(errors[0].message);
						}
					} else {
						searchInput.setCustomValidity("Unknown error");
					}
					searchInput.reportValidity();
					break;
			}
		}));

		$A.enqueueAction(action);
	}
})