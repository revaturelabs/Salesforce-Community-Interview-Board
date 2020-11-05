({
	loadQuestion : function(component, event) {
        var qList = event.getParam("questions");
        console.log(qList);
        component.set("v.QuestionList", qList);
        var index = component.get("v.QListIndex");
        console.log(index);
        var currentQ = qList[index];
        console.log(currentQ);
        var questionBody = currentQ["Body__c"];
        console.log(currentQ["Body__c"]);
        component.set("v.QuestionText", currentQ["Body__c"]);
        var questionId = currentQ["Id"];
        console.log(questionId);
        component.set("v.QuestionId", questionId);
	}
})