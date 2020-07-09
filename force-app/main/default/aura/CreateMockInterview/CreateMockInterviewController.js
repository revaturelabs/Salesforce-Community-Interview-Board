({
    doinit : function(component, event, helper) {
        var pickListStackValues;
        var outputList = [];
        
        var action = component.get("c.getTypePicklistValues");
        
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                // pickListStackValues = response.getReturnValue();
                // for(let stack of pickListStackValues) {
                //     outputList.push({label : stack,value : stack});
                // }
                // component.set("v.Stack",outputList);
                let bigMap = response.getReturnValue();
                component.set("v.TypeMap",bigMap);
                component.set("v.AllStacks",Object.keys(bigMap));
                console.log(bigMap);
                console.log(Object.keys(bigMap));
            } else {
                console.log("Failed in Create Mock Interview Controller (JS)")
            }
        })


        $A.enqueueAction(action);
    },

    ChangeLeftSideTypes : function(component, event, helper){
        console.log(component.find("stack id").get("v.value"));

    }
})
