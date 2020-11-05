({
    handleCompareEvent : function(component, event, helper) {
        let communityBestAnswer = component.get('v.communityBestAnswer');
        let userAnswer = event.get('userAnswer');
        let questionId = event.get('questionId');
        helper.handleCompareEvent(component, event, communityBestAnswer, userAnswer, questionId);
    }
})
