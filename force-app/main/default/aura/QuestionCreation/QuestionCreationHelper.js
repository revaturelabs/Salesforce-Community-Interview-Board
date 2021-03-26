({
    //Sets the meetings attribute with a list of all Meeting records obtained from the apex controller.
    loadMeetingsAndTypeMap : function(component, event) {
        var getMeetingsAction = component.get('c.loadAllMeetings');
        getMeetingsAction.setCallback(this, function(response){

            if (response.getState() == "SUCCESS"){
               component.set("v.meetings", response.getReturnValue());
            }
        })
        $A.enqueueAction(getMeetingsAction);
        var getTypeMapAction = component.get("c.getTypePicklistValues");
        getTypeMapAction.setCallback(this,function(response){
            if(response.getState()==="SUCCESS") {
                let bigMap = response.getReturnValue();
                component.set("v.allStacks",Object.keys(bigMap));
                component.set("v.typeMap",bigMap);
            }
        });
        $A.enqueueAction(getTypeMapAction);
    },
    
    saveQuestionHelper : function(component, quest, type, stack, meet, associate) {
            //console.log('In the helper method');
        //Initialize the apex controller and set it's paramaters
        var saveQuestionAction = component.get("c.saveQuestion");
        saveQuestionAction.setParams({question : quest, meeting: meet, type : type, stack : stack, associate: associate});
  
        //Set the callback and enqueue the apex controller
        saveQuestionAction.setCallback(this, function(response){
            if(response.getState() == "SUCCESS"){
                //After the record is submitted, reset the component values to blank
                    //console.log('In the callback\nFiring event to remove the addQuestion popup');
                component.set("v.question", null);
            	alert("You have successfuly entered a question");
                let fireEvent = component.getEvent('questionSubmitted');
                fireEvent.fire();
            }
            //Display message to user of a successful transaction
        })
            //console.log('Calling the Server side method asynchronously');
        $A.enqueueAction(saveQuestionAction); 
    },
    
    getUserType : function(component) {
        let action = component.get('c.isAssociate');
        action.setCallback(this, (res) => {
            component.set('v.isAssociate', res.getReturnValue());
        });
        $A.enqueueAction(action);
    }
})