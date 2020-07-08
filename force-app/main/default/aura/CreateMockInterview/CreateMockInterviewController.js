({
    doinit : function(component, event, helper) {
            var pickListValues;
            
            var action = component.get("c.getPicklistTypeValues");
            
            action.setCallback(this,function(response){
                var state = response.getState();
                if(state === "SUCCESS"){
                    pickListValues = response.getReturnValue();
                }
            })



    }
})
