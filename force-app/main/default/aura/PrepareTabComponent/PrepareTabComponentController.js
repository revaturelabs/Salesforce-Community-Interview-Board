({
    launchPanel : function(component, event, helper) {
		var qList = event.getParam("questions");
        var bool = event.getParam("display");
        component.set("v.QuestionList", qList);
        component.set("v.hidePanel", bool);
    }
})