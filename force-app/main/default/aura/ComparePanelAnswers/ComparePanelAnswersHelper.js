({
    handleCompareEvent : function(component, event, userAnswer, questionId){
        let getBestAnswer = component.get("c.getBestResponse");
        getBestAnswer.setParam("questionId" , questionId);
        getBestAnswer.setCallback(this, function(response){
            if(response.getState() === "SUCCESS"){
                component.set("communityBestAnswer", response.getReturnValue());
                let communityBestAnswer = component.get('v.communityBestAnswer');
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
