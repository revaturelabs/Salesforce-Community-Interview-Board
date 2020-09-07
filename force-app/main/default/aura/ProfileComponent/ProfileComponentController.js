({
	doInit : function(component, event, helper) {
		console.log('inside init');
        helper.Username(component,event);
        helper.StackScore(component,event);
        helper.PrimaryTechscore(component,event);
        helper.getSubTechScore(component,event);
	}
})