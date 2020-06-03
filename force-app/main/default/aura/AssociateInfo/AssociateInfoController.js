({
    doInit : function(component, event, helper) {
        var action = component.get("c.getContact");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.contact", response.getReturnValue());
                console.log(response.getReturnValue());
            }
         });
         $A.enqueueAction(action); 
    },
    handleEvent : function(cmp, event, helper) {
        var id = event.getParam("AId");
        cmp.set('v.recordId', id);
    }
})