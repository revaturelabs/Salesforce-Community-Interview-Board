({
	init : function(component, event, helper) {
        console.log("Run");
        let userId = $A.get("$SObjectType.CurrentUser.Id");
	}
})