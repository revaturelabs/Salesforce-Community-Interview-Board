({
    //Sets the batchAccount attribute with a list of all batch Accounts obtained from the apex controller.
    loadMeetings : function(component, event) {
        var getMeetingsAction = component.get('c.loadAllMeetings');
        getMeetingsAction.setCallback(this, function(response){

            if (response.getState() == "SUCCESS"){
                console.log(response.getReturnValue());
               component.set("v.meetings", response.getReturnValue());
            }
        })
        $A.enqueueAction(getMeetingsAction);
    },
    
    saveQuestionHelper : function(component, sub, quest) {
        //Initialize the apex controller and set it's paramaters
        var saveQuestionAction = component.get("c.saveQuestion");
        saveQuestionAction.setParams({subject : sub, question : quest});
  
        //Set the callback and enqueue the apex controller
        saveQuestionAction.setCallback(this, function(response){
            if(response.getState() == "SUCCESS"){
                //After the record is submitted, reset the component values to blank
                component.set("v.subject", "");
                component.set("v.question", "");
            }
            //Display message to user of a successful transaction
            alert("You have successfuly entered a question");
        })
        $A.enqueueAction(saveQuestionAction); 
    }
})
