({
    handleCompareEvent : function(component, event, communityBestAnswer, userAnswer) {
        let getScore = component.get("c.textSimilarity");
        getScore.setParams({"mockInterviewResponse" : userAnswer, "bestCommunityAnswer" : communityBestAnswer});
        getScore.setCallback(this, function(response){
            if(response.getState() === "SUCCESS"){
                component.set("similarityScore", response.getReturnValue());
            }
        });
        $A.enqueueAction(getScore);
    }
})
