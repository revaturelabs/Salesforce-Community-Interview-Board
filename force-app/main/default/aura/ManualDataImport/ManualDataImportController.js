({
    createTestData : function(component, event, helper) {
        
        let resetNow = component.get('c.reset');

        resetNow.setCallback(this, function(response){
            
        });
        $A.enqueueAction(resetNow);

        let createNow = component.get('c.questions');

        createNow.setCallback(this, function(response){

        });
        $A.enqueueAction(createNow);
    }
})
