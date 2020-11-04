({
    handleCompareEvent : function(component, event, communityBestAnswer, userAnswer, questionId){
        let getBestAnswer = component.get("c.getBestResponse");
        getBestAnswer.setParam("questionId" , questionId);
        getBestAnswer.setCallback(this, function(response){
            if(response.getState() === "SUCCESS"){
                component.set("communityBestAnswer", response.getReturnValue());
                this.getSimilarityScore(component, event, communityBestAnswer, userAnswer);
            }
        });
        $A.enqueueAction(getBestAnswer);
    },

    getSimilarityScore : function(component, event, communityBestAnswer, userAnswer) {
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
