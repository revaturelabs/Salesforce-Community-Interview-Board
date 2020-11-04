({
    handleCompareEvent : function(component, event, helper) {
        let communityBestAnswer = component.get('v.communityBestAnswer');
        let userAnswer = component.get('v.userAnswer');
        helper.handleCompareEvent(component, event, communityBestAnswer, userAnswer);
    }
})
