({
	doInit : function(component, event, helper) {
        
        var mQuestions = component.get("v.questionMap");
        var action = component.get("c.loadQuestionMap");
        var action2 = component.get("c.getMeetings");
        action.setCallback(this,function(response){
            if(response.getState()=="SUCCESS")
            {
                component.set("v.QuestionMap",response.getReturnValue());
            }
            
        });
        
        $A.enqueueAction(action);
        
        action2.setCallback(this,function(response){
            if(response.getState()=="SUCCESS")
            {
                component.set("v.meetings",response.getReturnValue());
            }
            
        });
        
        $A.enqueueAction(action2);
		
	}
})