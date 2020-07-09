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
        component.set("v.DisplayList", false);
        var selectedStack = component.find("stack id").get("v.value");
        console.log(typeof selectedStack);
        var stackTypeMap = component.get("v.TypeMap");
        console.log(Object.keys(stackTypeMap));
        var leftSideList = [];
        var tempList = [];
        tempList = stackTypeMap[selectedStack];
        //console.log(leftSideList);

        if (selectedStack) {
            for(let type of tempList) {
                leftSideList.push({label : type,value : type});
                 }
            component.set("v.LeftSideTypes", leftSideList);
            console.log(component.get("v.LeftSideTypes"));
        }
        component.set("v.DisplayList", true);
    }
})