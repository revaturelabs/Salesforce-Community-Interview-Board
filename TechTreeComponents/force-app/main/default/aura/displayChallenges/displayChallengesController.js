({
    myAction : function(component, event, helper) {
        var chalId = component.get("v.ChallengeApexData.Id");
        helper.challengeCompleteButton(component, chalId);
    }
})
