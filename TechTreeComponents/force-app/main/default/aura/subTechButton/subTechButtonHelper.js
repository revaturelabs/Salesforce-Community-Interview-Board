({
    setCur : function(component, curId) {
        let action = component.get("c.challenges");
        action.setParams({curId:JSON.stringify(curId)});
        action.setCallback(this, function(response){
            let state = response.getState();
            console.log(response.getState());
            if(state === "SUCCESS"){
                var curEve = component.getEvent("getCur");
                curEve.setParams({"cur":response.getReturnValue()});
                console.log(response.getReturnValue());
                curEve.fire();
            }
        });
        $A.enqueueAction(action);
        
    }
})
