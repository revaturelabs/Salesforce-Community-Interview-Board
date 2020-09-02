({
    prime : function(component) {
        console.log("here");
        let action = component.get("c.getTech");
        console.log("after");
        action.setCallback(this, function(response){
            let state = response.getState();
            console.log(response.getState());
            if(state === "SUCCESS"){
                component.set("v.primeTech", response.getReturnValue());
                console.log(response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },

    setSub : function(component, event) {
        let subTech = event.getParam("sub");
        component.set("v.subTech", subTech);
    }
})
