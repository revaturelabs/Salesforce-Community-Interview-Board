({
    handleCompareEventHelp : function(component, event, helper){
        console.log("In helper handler");
        let userAnswer = component.get("v.userAnswer");
        console.log("try get id " + userAnswer);
        let questionId = component.get("v.id");
        console.log("try get id 2" + questionId);
        let getBestAnswer = component.get("c.getBestResponse");
        console.log("try get id 3");
        getBestAnswer.setParams({"questionId" : questionId});
        getBestAnswer.setCallback(this, function(response){
            if(response.getState() === "SUCCESS"){
                console.log("in success of helper");
                component.set("v.communityBestAnswer", response.getReturnValue());
                //let communityBestAnswer = component.get('v.communityBestAnswer');
                this.getSimilarityScore(component, event);
            }
        });
        $A.enqueueAction(getBestAnswer);
    },

    getSimilarityScore : function(component, event) {
        console.log("In getsimilarity score");
        let userAnswer = component.get("v.userAnswer");
        let communityBestAnswer = component.get('v.communityBestAnswer');
        let getScore = component.get("c.textSimilarity");
        getScore.setParams({"mockInterviewResponse" : userAnswer , "bestCommunityAnswer" : communityBestAnswer});
        getScore.setCallback(this, function(response){
            if(response.getState() === "SUCCESS"){
                console.log("in success of getsimilarity score");
                console.log(response.getReturnValue());
                component.set("v.similarityScore", response.getReturnValue());
            }
        });
        $A.enqueueAction(getScore);
    }
})