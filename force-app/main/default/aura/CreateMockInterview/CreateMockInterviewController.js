({
    doinit : function(component, event, helper) {
        var pickListStackValues;
        var outputList = [];
        var action = component.get("c.getTypePicklistValues");
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
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
        var stackTypeMap = component.get("v.TypeMap");
        var leftSideList = [];
        var tempList = [];
        tempList = stackTypeMap[selectedStack];
        if (selectedStack) {
            for(let type of tempList) {
                leftSideList.push({label : type,value : type});
                 }
            component.set("v.LeftSideTypes", leftSideList);
        }
        component.set("v.DisplayList", true);
    },

    createMockInterviewJS : function(component,event,helper) {
        var action = component.get("c.createMockInterview");
        var rightTypes = component.get("v.RightSideTypes");
        var numbQuestions = component.get("v.numberOfQuestions");
        action.setParams({numQuestions : numbQuestions, filter : rightTypes});
        action.setCallback(this,function(response){
            if(response.getState()==="SUCCESS"){
                console.log("Created Mock Interview");
            } else {
                console.log("Successfully Failed");
            }
        });
        $A.enqueueAction(action);
    },

    holdRightSideTypes : function(component, event, helper) {
        var rightSideTypes = event.getParam("value");
        console.log(rightSideTypes);
        component.set("v.RightSideTypes", rightSideTypes);
    },

    HoldNumberOfQuestions : function (component, event, helper){
        var numbQuestions = event.getParam("value");
        console.log(numbQuestions);
        component.set("v.numberOfQuestions", numbQuestions);
    }
})