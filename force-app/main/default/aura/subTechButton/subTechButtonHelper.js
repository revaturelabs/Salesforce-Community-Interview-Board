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
    
    /*setComp :function(component){
        let challs = curEve.getParam("cur");
        let action = component.get("c.completions");
        action.setParams({challs:challs});
        action.setCallback(this, function(response){
            let state = response.getState();
            console.log(response.getState());
            if(state === "SUCCESS"){
                var curEve = component.getEvent("getCur");
                curEve.setParams({"comp":response.getReturnValue()});
                console.log(response.getReturnValue());
                curEve.fire();
            }
        });
        $A.enqueueAction(action);
    }*/
})