({
	activeQuestionPool : function(component, event, helper) {
        //get child component and call getData method
        // will refresh question pool list when tabbing back
        var child = component.find("poolList");
        child.getData(child, event);
	}
})