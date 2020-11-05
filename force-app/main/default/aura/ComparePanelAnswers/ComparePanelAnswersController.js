({
    handleCompareEvent : function(component, event, helper) {
        let communityBestAnswer = component.get('v.communityBestAnswer');
        let userAnswer = component.get('v.userAnswer');
        let questionId = component.get('v.id');
        helper.handleCompareEvent(component, event, communityBestAnswer, userAnswer, questionId);
    }
})