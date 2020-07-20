({
    onClose : function(component, event, helper) {
        component.set("v.displayFlow", false);

    },
    
    launchFlow : function(component, event, helper) {
        var useless = event.getParam("MockId");
        component.set("v.displayFlow", true);
    }
})