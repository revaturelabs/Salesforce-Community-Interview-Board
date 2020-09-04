({
    loadTech : function(component, event, helper) {
        helper.prime(component);
    },

    loadSub : function(component, event, helper) {
        helper.setSub(component, event);
    },

    showCur : function(component,event, helper) {
        component.set("v.ChallengeItems", event.getParam("cur"));
        var items = component.get("v.ChallengeItems");
        component.set("v.ChallengeDisplay", items);
        component.set("v.clicked", true);
    },
    fillAll : function(component, event, helper) {
        var items = component.get("v.ChallengeItems");
        component.set("v.ChallengeDisplay", items);
    },
    fillCont : function(component, event, helper) {
        helper.setCont(component);
    },
    fillComp : function(component, event, helper) {
        helper.setComp(component);
    }
})