({
	doInit : function(component, event, helper) {
        
        var mQuestions = component.get("v.questionMap");
        var action = component.get("c.loadQuestionMap");
        var meetings = component.get("v.meetings");
        
        action.setCallback(this,function(response){
            if(response.getState()=="SUCCESS")
            {
                component.set("v.QuestionMap",response.getReturnValue());

                for (let key of mQuestions.keys())
                {
                    meetings.push(key);
                }

                component.set("v.meetings",meetings);
            }
            
        });
        
        $A.enqueueAction(action);
		
	}
})