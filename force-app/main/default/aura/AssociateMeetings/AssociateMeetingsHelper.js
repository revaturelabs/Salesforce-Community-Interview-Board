({
    getMeetings: function(component) {
		var action = component.get("c.getMeetings");
		action.setCallback(this, $A.getCallback(function (response) {
			if (response.getState() === "SUCCESS") {
				component.set("v.meetings", response.getReturnValue());
			} else {
				console.error(response.getError());
			}
		}));
		$A.enqueueAction(action);
	}
})
