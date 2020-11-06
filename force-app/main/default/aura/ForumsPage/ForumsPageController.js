({
	salesforceClicked : function(component, event, helper) {
        
        switch((event.currentTarget.id).toString()){
            case 'salesforce-softskills':
                var action = component.get("c.getQuestionList");
                        action.setParams({categoryName : 'Salesforce', subCatName : 'Soft Skills'});
                action.setCallback(this, function(response){
                    var name = response.getState();
                    if (name === "SUCCESS") {
                        console.log('Success');
                        component.set("v.questionsList", response.getReturnValue());
                    }
                });
             	$A.enqueueAction(action);
                break;
            case 'salesforce-apex':
                var action = component.get("c.getQuestionList");
                        action.setParams({categoryName : 'Salesforce', subCatName : 'Apex'});
                action.setCallback(this, function(response){
                    var name = response.getState();
                    if (name === "SUCCESS") {
                        console.log('Success');
                        component.set("v.questionsList", response.getReturnValue());
                    }
                });
             	$A.enqueueAction(action);
                break;
            case 'salesforce-apex-trigger':
                var action = component.get("c.getQuestionList");
                        action.setParams({categoryName : 'Salesforce', subCatName : 'Apex Trigger'});
                action.setCallback(this, function(response){
                    var name = response.getState();
                    if (name === "SUCCESS") {
                        console.log('Success');
                        component.set("v.questionsList", response.getReturnValue());
                    }
                });
             	$A.enqueueAction(action);
                break;
            case 'salesforce-apex-testing':
                var action = component.get("c.getQuestionList");
                        action.setParams({categoryName : 'Salesforce', subCatName : 'Apex Testing'});
                action.setCallback(this, function(response){
                    var name = response.getState();
                    if (name === "SUCCESS") {
                        console.log('Success');
                        component.set("v.questionsList", response.getReturnValue());
                    }
                });
             	$A.enqueueAction(action);
                break;
            case 'salesforce-visualforce':
                var action = component.get("c.getQuestionList");
                        action.setParams({categoryName : 'Salesforce', subCatName : 'Visualforce'});
                action.setCallback(this, function(response){
                    var name = response.getState();
                    if (name === "SUCCESS") {
                        console.log('Success');
                        component.set("v.questionsList", response.getReturnValue());
                    }
                });
             	$A.enqueueAction(action);
                break;
            case 'salesforce-components':
                var action = component.get("c.getQuestionList");
                	action.setParams({categoryName : 'Salesforce', subCatName : 'Aura/Lightning Components'});
                action.setCallback(this, function(response){
                    var name = response.getState();
                    if (name === "SUCCESS") {
                        console.log('Success');
                        component.set("v.questionsList", response.getReturnValue());
                    }
                });
             	$A.enqueueAction(action);
                break;
            case 'salesforce-declarative':
                var action = component.get("c.getQuestionList");
                        action.setParams({categoryName : 'Salesforce', subCatName : 'Declarative Salesforce'});
                action.setCallback(this, function(response){
                    var name = response.getState();
                    if (name === "SUCCESS") {
                        console.log('Success');
                        component.set("v.questionsList", response.getReturnValue());
                    }
                });
             	$A.enqueueAction(action);
                break;
            case 'salesforce-soql':
                var action = component.get("c.getQuestionList");
                        action.setParams({categoryName : 'Salesforce', subCatName : 'SOQL/SOSL'});
                action.setCallback(this, function(response){
                    var name = response.getState();
                    if (name === "SUCCESS") {
                        console.log('Success');
                        component.set("v.questionsList", response.getReturnValue());
                    }
                });
             	$A.enqueueAction(action);
                break;
            case 'salesforce-html':
                var action = component.get("c.getQuestionList");
                        action.setParams({categoryName : 'Salesforce', subCatName : 'HTML/CSS'});
                action.setCallback(this, function(response){
                    var name = response.getState();
                    if (name === "SUCCESS") {
                        console.log('Success');
                        component.set("v.questionsList", response.getReturnValue());
                    }
                });
             	$A.enqueueAction(action);
                break;
            case 'salesforce-javascript':
                var action = component.get("c.getQuestionList");
                        action.setParams({categoryName : 'Salesforce', subCatName : 'JavaScript'});
                action.setCallback(this, function(response){
                    var name = response.getState();
                    if (name === "SUCCESS") {
                        console.log('Success');
                        component.set("v.questionsList", response.getReturnValue());
                    }
                });
             	$A.enqueueAction(action);
                break;
        }
        component.set("v.showQuestionsList", true);
        component.set("v.showQuestion", false);
	},
	javaClicked : function(component, event, helper) {
                
        switch((event.currentTarget.id).toString()){
            case 'java-softskills':
                var action = component.get("c.getQuestionList");
                        action.setParams({categoryName : 'Java', subCatName : 'Soft Skills'});
                action.setCallback(this, function(response){
                    var name = response.getState();
                    if (name === "SUCCESS") {
                        console.log('Success');
                        component.set("v.questionsList", response.getReturnValue());
                    }
                });
             	$A.enqueueAction(action);
                break;
            case 'java-java':
                var action = component.get("c.getQuestionList");
                        action.setParams({categoryName : 'Java', subCatName : 'Java'});
                action.setCallback(this, function(response){
                    var name = response.getState();
                    if (name === "SUCCESS") {
                        console.log('Success');
                        component.set("v.questionsList", response.getReturnValue());
                    }
                });
             	$A.enqueueAction(action);
                break;
            case 'java-react':
                var action = component.get("c.getQuestionList");
                        action.setParams({categoryName : 'Java', subCatName : 'React'});
                action.setCallback(this, function(response){
                    var name = response.getState();
                    if (name === "SUCCESS") {
                        console.log('Success');
                        component.set("v.questionsList", response.getReturnValue());
                    }
                });
             	$A.enqueueAction(action);
                break;
            case 'java-spring':
                var action = component.get("c.getQuestionList");
                        action.setParams({categoryName : 'Java', subCatName : 'Spring'});
                action.setCallback(this, function(response){
                    var name = response.getState();
                    if (name === "SUCCESS") {
                        console.log('Success');
                        component.set("v.questionsList", response.getReturnValue());
                    }
                });
             	$A.enqueueAction(action);
                break;
            case 'java-typescript':
                var action = component.get("c.getQuestionList");
                        action.setParams({categoryName : 'Java', subCatName : 'Typescript'});
                action.setCallback(this, function(response){
                    var name = response.getState();
                    if (name === "SUCCESS") {
                        console.log('Success');
                        component.set("v.questionsList", response.getReturnValue());
                    }
                });
             	$A.enqueueAction(action);
                break;
            case 'java-nodejs':
                var action = component.get("c.getQuestionList");
                        action.setParams({categoryName : 'Java', subCatName : 'Node.Js'});
                action.setCallback(this, function(response){
                    var name = response.getState();
                    if (name === "SUCCESS") {
                        console.log('Success');
                        component.set("v.questionsList", response.getReturnValue());
                    }
                });
             	$A.enqueueAction(action);
                break;
            case 'java-javascript':
                var action = component.get("c.getQuestionList");
                        action.setParams({categoryName : 'Java', subCatName : 'JavaScript'});
                action.setCallback(this, function(response){
                    var name = response.getState();
                    if (name === "SUCCESS") {
                        console.log('Success');
                        component.set("v.questionsList", response.getReturnValue());
                    }
                });
             	$A.enqueueAction(action);
                break;
        }
        component.set("v.showQuestionsList", true);
        component.set("v.showQuestion", false);
	},
	netClicked : function(component, event, helper) {
                
        switch((event.currentTarget.id).toString()){
            case '.net-softskills':
                var action = component.get("c.getQuestionList");
                        action.setParams({categoryName : '.NET', subCatName : 'Soft Skills'});
                action.setCallback(this, function(response){
                    var name = response.getState();
                    if (name === "SUCCESS") {
                        console.log('Success');
                        component.set("v.questionsList", response.getReturnValue());
                    }
                });
             	$A.enqueueAction(action);
                break;
            case '.net-c':
                var action = component.get("c.getQuestionList");
                        action.setParams({categoryName : '.NET', subCatName : 'C'});
                action.setCallback(this, function(response){
                    var name = response.getState();
                    if (name === "SUCCESS") {
                        console.log('Success');
                        component.set("v.questionsList", response.getReturnValue());
                    }
                });
             	$A.enqueueAction(action);
                break;
            case '.net-cs':
                var action = component.get("c.getQuestionList");
                        action.setParams({categoryName : '.NET', subCatName : 'C#'});
                action.setCallback(this, function(response){
                    var name = response.getState();
                    if (name === "SUCCESS") {
                        console.log('Success');
                        component.set("v.questionsList", response.getReturnValue());
                    }
                });
             	$A.enqueueAction(action);
                break;
            case '.net-cpp':
                var action = component.get("c.getQuestionList");
                        action.setParams({categoryName : '.NET', subCatName : 'C++'});
                action.setCallback(this, function(response){
                    var name = response.getState();
                    if (name === "SUCCESS") {
                        console.log('Success');
                        component.set("v.questionsList", response.getReturnValue());
                    }
                });
             	$A.enqueueAction(action);
                break;
            case '.net-sql':
                var action = component.get("c.getQuestionList");
                        action.setParams({categoryName : '.NET', subCatName : 'SQL'});
                action.setCallback(this, function(response){
                    var name = response.getState();
                    if (name === "SUCCESS") {
                        console.log('Success');
                        component.set("v.questionsList", response.getReturnValue());
                    }
                });
             	$A.enqueueAction(action);
                break;
            case '.net-python':
                var action = component.get("c.getQuestionList");
                        action.setParams({categoryName : '.NET', subCatName : 'Python'});
                action.setCallback(this, function(response){
                    var name = response.getState();
                    if (name === "SUCCESS") {
                        console.log('Success');
                        component.set("v.questionsList", response.getReturnValue());
                    }
                });
             	$A.enqueueAction(action);
                break;
            case '.net-javascript':
                var action = component.get("c.getQuestionList");
                        action.setParams({categoryName : '.NET', subCatName : 'JavaScript'});
                action.setCallback(this, function(response){
                    var name = response.getState();
                    if (name === "SUCCESS") {
                        console.log('Success');
                        component.set("v.questionsList", response.getReturnValue());
                    }
                });
             	$A.enqueueAction(action);
                break;
        }
        component.set("v.showQuestionsList", true);
        component.set("v.showQuestion", false);
	},
	popCultureClicked : function(component, event, helper) {
                
        switch((event.currentTarget.id).toString()){
            case 'pc-fun':
                var action = component.get("c.getQuestionList");
                        action.setParams({categoryName : 'Pop Culture', subCatName : 'C'});
                action.setCallback(this, function(response){
                    var name = response.getState();
                    if (name === "SUCCESS") {
                        console.log('Success');
                        component.set("v.questionsList", response.getReturnValue());
                    }
                });
             	$A.enqueueAction(action);
                break;
        }
        component.set("v.showQuestionsList", true);
        component.set("v.showQuestion", false);
    }, testFunction : function(component, event, helper) {
        component.set("v.showQuestionsList", false);
        component.set("v.showQuestion", true);
        let evt = $A.get("e.c:ResponseQuestionEvent");
        evt.setParams({"question_id" : event.currentTarget.id})
        evt.fire();
    }
})