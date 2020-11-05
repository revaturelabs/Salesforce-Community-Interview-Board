({
	//method for retreiving the list of panel questions from the UpdateMockPanelList event and storing them in the component
    retrievePanelQuestions : function(component, event, helper) {
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
    
    //initializes the current question on the page;
    doinit : function(cmp, evt, help) {
        console.log("intializing");
        help.loadQuestion(cmp, evt);
    },
    
    //increments the value of the index attribute.
    nextQuestion : function(cmp, evt, help){
        cmp.set("v.QListIndex", cmp.get("v.QListIndex") + 1);
        help.loadQuestion(cmp, evt);
        cmp.set("v.submitted", false);
    }
})