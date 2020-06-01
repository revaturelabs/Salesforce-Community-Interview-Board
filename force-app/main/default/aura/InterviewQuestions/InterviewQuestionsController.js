({
	doInit : function(component, event, helper) {
        //on init, get all the meetings and questions we need
        var action = component.get("c.loadQuestionMap");
        
        action.setCallback(this,function(response){
            if(response.getState()==="SUCCESS")
            {
                //unpack the meetings from the List<List<Sobjects>>
                //use the helper to unpack the questions
                var result = response.getReturnValue();
                component.set("v.meetings", result[0]);
                helper.createMap(component, result[0], result[1]);
            }
            
        });
        
        $A.enqueueAction(action);
		
    },
    //changing questions based on the meeting
    changeMeeting : function(component, event, helper) {
        component.set("v.questions", component.get("v.questionMap")[event.getSource().get("v.value")]);
        helper.resetPage(component);
        helper.disable(component);
    },
    
    //pagination management
    prevPage : function(component, event, helper) {
        component.set("v.page", component.get("v.page") - 1);
        helper.setPage(component);
        helper.disable(component);
    },
    
    nextPage : function(component, event, helper) {
        component.set("v.page", component.get("v.page") + 1);
        helper.setPage(component);
        helper.disable(component);
    },
})