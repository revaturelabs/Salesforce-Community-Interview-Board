({
    doinit : function(component, event, helper) {
        helper.doinit(component, event);
    },
    getData : function(component, event, helper) {
        helper.getData(component, event);
    },
    selectQuestion : function(component,event,helper) {
        helper.selectQuestion(component, event);
    },
    selectResponse : function(component,event,helper){
        helper.selectResponse(component, event);
    },
    deleteButton : function(component,event,helper) {
        helper.deleteButton(component, event);
	},
    deleteResponse : function(component,event,helper) {
        helper.deleteResponse(component, event);
    },
    lockButton : function(component, event, helper){
    	helper.lockResponse(component, event);
	}
    
})