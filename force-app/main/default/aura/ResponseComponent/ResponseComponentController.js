({
	textChanged : function(component, event, helper) {
        let username = component.find("subBody").get("v.value");
		component.set("v.body", username);
	},
    
    init: function(component, event, helper){
        
    },
    
    
     
    
    createResponse : function(component, event, helper){
        
        let action = component.get("c.addResponse");
        let question = component.get("v.question");
        let response = component.get("v.body");
        if (response == null) {
              var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title: "Can't submit",
                    message: "There is no response to submit!",
                    type: "error"
                });
            toastEvent.fire();
           			}
        else{
            action.setParams({body:response, questionBody:question});
        action.setCallback(this, function(response){
            var name = response.getState();
            if (name === "SUCCESS"&& response!=null) {
                helper.getResponse(component, event, helper);
            }
    })
        
     		$A.enqueueAction(action);
            var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title: "Response submitted",
                    message: "Thank you for your response!",
                    type: "success"
                });
            toastEvent.fire();
            
        }
       
        
        
        
    },
    handleLikeButtonClick : function(component, event, helper) {
        helper.updateLikes(1, component, event);
	},
    handleDislikeButtonClick : function(component, event, helper) {
        helper.updateLikes(-1, component, event);
	},
    getQuestionFromEvent : function(component, event, helper) {
        let question = event.getParam("question_id");
        component.set("v.get_question_id", question);
        helper.displayQuestion(component, event, helper);
    }
    
     
   
                           
        
   
    
    
})