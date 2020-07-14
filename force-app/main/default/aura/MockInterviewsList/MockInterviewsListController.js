({
    doinit : function(component, event, helper) {
        helper.createList(component);

    },
    
    refreshComponent : function(component, event, helper) {
        component.set('v.DisplayPage',false);
        helper.createList(component);
        component.set('v.DisplayPage',true);
    }
})