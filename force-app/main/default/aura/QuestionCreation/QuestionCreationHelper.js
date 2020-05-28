({
    saveQuestionHelper : function(component, sub, quest) {
        //Initialize the apex controller and set it's paramaters
        var action = component.get("c.saveQuestion");
        action.setParams({subject : sub, question : quest});
  
        //Set the callback and enqueue the apex controller
        action.setCallback(this, function(response){
            if(response.getState() == "SUCCESS"){
                //After the record is submitted, reset the component values to blank
                component.set("v.subject", "");
                component.set("v.question", "");
            }
            //Display message to user of a successful transaction
            alert("You have successfuly entered a question");
        })
        $A.enqueueAction(action); 
    }
})
