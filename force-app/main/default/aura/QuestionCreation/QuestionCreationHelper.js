({
    //Sets the meetings attribute with a list of all Meeting records obtained from the apex controller.
    loadMeetings : function(component, event) {
        var getMeetingsAction = component.get('c.loadAllMeetings');
        getMeetingsAction.setCallback(this, function(response){

            if (response.getState() == "SUCCESS"){
               component.set("v.meetings", response.getReturnValue());
            }
        })
        $A.enqueueAction(getMeetingsAction);
    },
    
    saveQuestionHelper : function(component, sub, quest, meet) {
        //Initialize the apex controller and set it's paramaters
        var saveQuestionAction = component.get("c.saveQuestion");
        saveQuestionAction.setParams({subject : sub, question : quest, meeting: meet});
  
        //Set the callback and enqueue the apex controller
        saveQuestionAction.setCallback(this, function(response){
            if(response.getState() == "SUCCESS"){
                //After the record is submitted, reset the component values to blank
                component.set("v.subject", null);
                component.set("v.question", null);
            }
            //Display message to user of a successful transaction
            alert("You have successfuly entered a question");
        })
        $A.enqueueAction(saveQuestionAction); 
    }
})
