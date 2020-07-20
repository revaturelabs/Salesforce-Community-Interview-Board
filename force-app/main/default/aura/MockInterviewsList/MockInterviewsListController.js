({
    doinit : function(component, event, helper) {
        helper.createList(component);

    },
    
    refreshComponent : function(component, event, helper) {
        component.set('v.DisplayPage',false);
        helper.createList(component);
        component.set('v.DisplayPage',true);
    },

    startInterview : function(component, event, helper) {
        var mockId = component.get('v.MockId');
        var action = $A.get("e.c:FlowLaunch");
        action.setParams("MockId", mockId);
        action.fire(); 
    },

    HoldMockId : function(component, event, helper) {
        var rows = event.getParam("selectedRows");
        rows = rows[0];
        console.log(rows);
        var id = rows.id;
        component.set('v.MockId', id);
    }
})