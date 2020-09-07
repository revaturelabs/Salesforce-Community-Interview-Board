({
    subHelp : function(component, primeId) {
        console.log("here");
        console.log(primeId);
        let action = component.get("c.subList");
        action.setParams({primeId : JSON.stringify(primeId)});
        console.log("after");
        action.setCallback(this, function(response){
            let state = response.getState();
            console.log(response.getState());
            if(state === "SUCCESS"){
                var subEvent = component.getEvent("getSub");
                subEvent.setParams({"sub":response.getReturnValue()});
                subEvent.fire();
                console.log(response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }
})