({
    loadTech : function(component, event, helper) {
        helper.prime(component);
    },

    loadSub : function(component, event, helper) {
        helper.setSub(component, event);
    },

    showCur : function(component,event, helper) {
        component.set("v.currentTech", event.getParam("cur"));
        component.set("v.clicked", true);
    }
})
