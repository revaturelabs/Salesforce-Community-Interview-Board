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
                
                //Set New Map
                component.set("v.RightSideTypes", new Map());
            } else {
                console.log("Failed in Create Mock Interview Controller (JS)")
            }
        })


        $A.enqueueAction(action);
    },
    changeView : function(component, event, helper) {
        // Set Component to render through <aura:if> if true, otherwise hidden.
        component.set("v.viewState", event.getParam("viewState"));
    },

    handleFinishEvent : function(cmp, evt, help){
        // Set Component to render through <aura:if> if true, otherwise hidden.
        // Reset selected topics.
        cmp.set("v.viewState", evt.getParam("viewState"));
        cmp.set("v.default", []);
        help.setListValues(cmp, []);
        cmp.find("CreateButton").set("v.disabled", true);
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

    createMockPanelJS : function(component, event, helper) {
        // Call Apex method and send List<Map<String, Object>>
        let action = component.get("c.getNumQuestionListByTopic");
        
        // Create List<Map<String, Object>> from List and Maps
        let rightTypes = component.get("v.display");
        let listResult = [];
        for(let i = 0; i < rightTypes.length; i++) {
            if(rightTypes[i]['number'] > 0){
                listResult.push({ "name" : rightTypes[i]['name'], "number" : rightTypes[i]['number'] });
            }
        }
        action.setParams({"filterPanel" : listResult});
        action.setCallback(this,function(response){
            if(response.getState()==="SUCCESS"){
                // Fire Application Event and store response from Apex.
                let UpdateList = $A.get("e.c:UpdateMockPanelList");
                UpdateList.setParams({"questions" : response.getReturnValue(), "viewState" : false});
                UpdateList.fire();
            } else {
                console.log("An error has occured.");
            }
        });
        $A.enqueueAction(action);
    },

    holdRightSideTypes : function(component, event, helper) {
        var rightSideTypes = event.getParam("value");
        
        // Retrieve Map from list and add new Map
        helper.setListValues(component, rightSideTypes);
        if (rightSideTypes[0]) {
            component.find("CreateButton").set("v.disabled", false);
        } else {
            component.find("CreateButton").set("v.disabled", true);
        }
    },

    SelectAll : function (component, event, helper){
        var getAllLeftSide = component.get("v.LeftSideTypes");
        // Add all topics in this category
        var tempoList = [];
        for(let type of getAllLeftSide) {
            tempoList.push(type.value);
        }
        
        // Save and update List and Maps
        component.set("v.default", tempoList);
        helper.setListValues(component, tempoList);
        component.find("CreateButton").set("v.disabled", false);
    },

    DeselectAll : function (component, event, helper){
        //Remove all topics and reset values.
        component.set("v.default", []);
        helper.setListValues(component, []);
        component.find("CreateButton").set("v.disabled", true);
    },
    
    setValue : function(component, event, helper) {
        helper.setNewValue(component, event);
    }
})