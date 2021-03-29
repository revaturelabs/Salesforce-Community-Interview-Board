({
    createTestData : function(component, event, helper) {
        
        let resetNow = component.get('c.reset');

        resetNow.setCallback(this, function(response){
            
        });
        $A.enqueueAction(resetNow);
    }
})
