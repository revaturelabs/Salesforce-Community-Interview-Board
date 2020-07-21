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
                component.find("CreateButton").set("v.disabled", true);
            } else {
                console.log("Failed in Create Mock Interview Controller (JS)")
            }
        })


        $A.enqueueAction(action);
    },

    ChangeLeftSideTypes : function(component, event, helper){
        var selectedStack = component.find("stack id").get("v.value");
        var stackTypeMap = component.get("v.TypeMap");
        var leftSideList = [];
        var tempList = [];
        component.set("v.default", [""]);
        tempList = stackTypeMap[selectedStack];
        if (selectedStack) {
            for(let type of tempList) {
                leftSideList.push({label : type,value : type});
                 }
            component.set("v.LeftSideTypes", leftSideList);
        }
        component.find("CreateButton").set("v.disabled", true);
    },

    createMockInterviewJS : function(component,event,helper) {
        var action = component.get("c.createMockInterview");
        var rightTypes = component.get("v.RightSideTypes");
        var numbQuestions = component.get("v.numberOfQuestions");
        
        action.setParams({numQuestions : numbQuestions, filter : rightTypes});
        action.setCallback(this,function(response){
            if(response.getState()==="SUCCESS"){
                var UpdateList = $A.get("e.c:UpdateMockInterviewList");
                console.log(UpdateList);
                UpdateList.fire();
                console.log("Created Mock Interview");
                console.log(response.getReturnValue());
                location.reload();
            } else {
                console.log("An error has occured.");
            }
        });
        $A.enqueueAction(action);

        
    },

    holdRightSideTypes : function(component, event, helper) {
        var rightSideTypes = event.getParam("value");
        console.log(rightSideTypes);
        component.set("v.RightSideTypes", rightSideTypes);
        if (rightSideTypes[0]) {
            component.find("CreateButton").set("v.disabled", false);
        } else {
            component.find("CreateButton").set("v.disabled", true);
        }
    },

    HoldNumberOfQuestions : function (component, event, helper){
        var numbQuestions = event.getParam("value");
        console.log(numbQuestions);
        component.set("v.numberOfQuestions", numbQuestions);
    },

    SelectAll : function (component, event, helper){
        var getAllLeftSide = component.get("v.LeftSideTypes");
        var tempoList = [];
        console.log(getAllLeftSide);
        
        
        for(let type of getAllLeftSide) {
            tempoList.push(type.value);
        }
        console.log(tempoList);
        component.set("v.default", tempoList);
        console.log(tempoList);
        component.find("CreateButton").set("v.disabled", false);
    },

    DeselectAll : function (component, event, helper){
        component.set("v.default", [""]);
        component.find("CreateButton").set("v.disabled", true);
    }
})