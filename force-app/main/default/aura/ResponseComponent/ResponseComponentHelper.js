({
	getResponse : function(component, event, helper){
        let action = component.get("c.getResponse");
        let question = component.get("v.question");
        action.setParams({questionBody:question});
        action.setCallback(this, function(response){
            var name = response.getState();
            if (name === "SUCCESS") {
                component.set("v.responses", response.getReturnValue());
                helper.getPreviousVotes(component, event, helper);
           	}	
    })
        
     		$A.enqueueAction(action);
    },
    getPreviousVotes : function(component, event, helper){
        let action = component.get("c.getUserVotes");
        action.setCallback(this, function(response){
            var name = response.getState();
            if (name === "SUCCESS") {
                component.set("v.previousVotes", response.getReturnValue());
                let votes = component.get("v.previousVotes");
                let responses = component.get("v.responses");
                let r;
                for(r in responses){
                    let questionResponse = responses[r];
                    let rr;
                    for(rr in response.getReturnValue()){
                        let responseRating = response.getReturnValue()[rr];
                        if(questionResponse.Name == responseRating.Question_Response__r.Name){
                            console.log(questionResponse.Name + " = " + responseRating.Question_Response__r.Name);
                            if(responseRating.Rating__c == '1'){
                                questionResponse.liked = true;
                                questionResponse.disliked = false;
                            } else {
                                questionResponse.liked = false;
                                questionResponse.disliked = true;
                            }
                            console.log(responseRating);
                            console.log(responseRating.Rating__c);
                            console.log(questionResponse);
                        }
                    }
                }
                component.set("v.responses", responses);
           	}	
    })
        
     		$A.enqueueAction(action);
    },
    updateLikes : function(rating, component, event) {
        let responseName = event.getSource().get("v.class");
        let responses = component.get("v.responses");
        console.log("update likes");
        let r;
        for(r in responses){
            let response = responses[r];
            if(response.Name == responseName){
                 console.log("found response to update");
                console.log("rating", rating);
                if(rating == 1){
                    if(response.liked){
                        response.liked = false;
                        response.Upvotes__c--;
                        response.Total_Votes__c--;
                    } else if (response.disliked){
                        response.liked = true;
                        response.disliked = false;
                        response.Upvotes__c++;
                    } else {
                        console.log("first like");
                        response.liked = true;
                    	response.Upvotes__c++;
                        response.Total_Votes__c++;
                    }
                } else {
                    if(response.liked){
                        response.liked = false;
                        response.disliked = true;
                        response.Upvotes__c--;
                    } else if (response.disliked){
                        response.disliked = false;
                        response.Total_Votes__c--;
                    } else {
                        response.disliked = true;
                        response.Total_Votes__c++;
                    }
                }
            } 
        }
        console.log("update responses");
        component.set("v.responses", responses);
        
        
        //update database
        let action = component.get("c.rateResponse");
        action.setParams({'name':responseName,'rating':rating});
        action.setCallback(this, function(response){
            var name = response.getState();
            if (name === "SUCCESS") {
                console.log("vote submitted");
           	}	
    })
        
     		$A.enqueueAction(action);
            
	}, 
    displayQuestion : function(component, event, helper) {
        
        let action = component.get("c.getQuestion");
        action.setParams({questionID : component.get("v.get_question_id")});
        action.setCallback(this, function(response){
            var name = response.getState();
            if (name === "SUCCESS") {
                component.set("v.question", response.getReturnValue());
                helper.getResponse(component, event, helper);
            }
           
    })
        $A.enqueueAction(action);
    }
})