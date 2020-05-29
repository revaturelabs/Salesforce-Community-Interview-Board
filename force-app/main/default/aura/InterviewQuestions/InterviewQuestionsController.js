({
	doInit : function(component, event, helper) {
        
        var action = component.get("c.loadQuestionMap");
        
        action.setCallback(this,function(response){
            if(response.getState()==="SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.meetings", result[0]);
                helper.createMap(component, result[1]);
            }
            
        });
        
        $A.enqueueAction(action);
		
    },
    
    changeMeeting : function(component, event, helper) {
        console.log("this");
        component.set("v.questions", component.get("v.questionMap")[event.getSource().get("v.value")]);
        console.log("that");
    },

    changeSubject : function(component, event, helper) {

    }
})