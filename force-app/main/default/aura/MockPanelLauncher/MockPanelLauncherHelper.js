({
    //helper function that loads question data into the component
	loadQuestion : function(component, event) {
        let qList = component.get("v.QuestionList");
        var index = component.get("v.QListIndex");
        console.log(index);
        var currentQ = qList[index];
        console.log(currentQ);
        console.log(currentQ["Body__c"]);
        component.set("v.QuestionText", currentQ["Body__c"]);
        var questionId = currentQ["Id"];
        console.log(questionId);
        component.set("v.QuestionId", questionId);
        component.set("v.ResponseBody", "");
	}
})