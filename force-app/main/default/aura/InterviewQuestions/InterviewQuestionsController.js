({
	doInit : function(component, event, helper) {
        
        var mQuestions = component.get("v.questionMap");
        var action = component.get("c.loadQuestionMap");
        var meetings = component.get("v.meetings");
        
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

    },

    changeSubject : function(component, event, helper) {

    }
})