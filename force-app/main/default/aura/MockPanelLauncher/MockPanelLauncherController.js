({
	//method for retreiving the list of panel questions from the UpdateMockPanelList event and storing them in the component
    retrievePanelQuestions : function(component, event, helper) {
        component.set("v.viewState", event.getParam("viewState"));
        var qList = event.getParam("questions");
        component.set("v.QuestionList", qList);
        helper.loadQuestion(component, event);
        /*var qList = event.getParam("questions");
        console.log(qList);
        component.set("v.QuestionList", qList);
        var index = component.get("v.QListIndex");
        console.log(index);
        var currentQ = qList[index];
        console.log(currentQ);
        var questionBody = currentQ["Body__c"];
        console.log(currentQ["Body__c"]);
        component.set("v.QuestionText", currentQ["Body__c"]);*/
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
        if(cmp.get("v.QListIndex") + 1 == qList.length - 1){
            cmp.set("v.finalQuestion", true);
        }
        else{
        cmp.set("v.QListIndex", cmp.get("v.QListIndex") + 1);
        help.loadQuestion(cmp, evt);
        cmp.set("v.submitted", false);
        }
    },

    //button to reset panel and return to create mock panel component
    finishButton : function(cmp, evt, help){
        let finishEvent = $A.get("e.c:finishPanelEvent");
        finishEvent.setParams({"viewState": true});
        finishEvent.fire();
    },

    handleFinishEvent : function(cmp, evt, help){
        cmp.set("v.viewState", evt.getParam("viewState"));
    }
})