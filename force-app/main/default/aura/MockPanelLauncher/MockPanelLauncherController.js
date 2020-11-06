({
	//method for retreiving the list of panel questions from the UpdateMockPanelList event and storing them in the component
    retrievePanelQuestions : function(component, event, helper) {
        component.set("v.viewState", event.getParam("viewState"));
        component.set("v.QuestionList", event.getParam("questions"));
        helper.loadQuestion(component, event);
	},
    
    //saves text input into the response and presents buttons for Next question and 
    submitResponse : function(cmp, evt, help){
        var response = cmp.find("responseBody").get("v.value");
        console.log(response);
        cmp.set("v.ResponseBody", response);
        cmp.set("v.submitted", true);
    },
    
    //increments the value of the index attribute.
    nextQuestion : function(cmp, evt, help){
        let qList = cmp.get("v.QuestionList");
        console.log(qList);
        console.log(qList.length);
        if(cmp.get("v.QListIndex") + 1 == qList.length - 1){
            cmp.set("v.finalQuestion", true);
        }
        
        cmp.set("v.QListIndex", cmp.get("v.QListIndex") + 1);
        help.loadQuestion(cmp, evt);
        cmp.set("v.submitted", false);
    },

    //button to reset panel and return to create mock panel component
    finishButton : function(cmp, evt, help){
        cmp.set("v.QuestionList", []);
        cmp.set("v.QListIndex", 0);
        cmp.set("v.QuestionId", "");
        cmp.set("v.QuestionText", "");
        cmp.set("v.ResponseBody", "");
        cmp.set("v.submitted", false);
        cmp.set("v.finalQuestion", false);
        let finishEvent = $A.get("e.c:finishPanelEvent");
        finishEvent.setParams({"viewState": true});
        finishEvent.fire();
    },

    //handles finish event and returns view state to mock panel component
    handleFinishEvent : function(cmp, evt, help){
        cmp.set("v.viewState", evt.getParam("viewState"));
    },

    fireCompareEvent : function(cmp, evt, help){
        let appEvent = $A.get("e.c:CompareAppEvent");
        appEvent.setParams({"questonId" : "v.QuestionId" , "userAnswer" : "v.ResponseBody"});
        appEvent.fire();
    }
})