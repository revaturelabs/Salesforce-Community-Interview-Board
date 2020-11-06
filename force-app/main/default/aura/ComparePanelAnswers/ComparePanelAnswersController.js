({
    handleCompareEvent : function(component, event, helper) {
        console.log("In handleCompareEvent");
        //let communityBestAnswer = component.get('v.communityBestAnswer');
        let userAnswer = event.get('userAnswer');
        let questionId = event.get('questionId');
        helper.handleCompareEvent(component, event, userAnswer, questionId);
    }
})