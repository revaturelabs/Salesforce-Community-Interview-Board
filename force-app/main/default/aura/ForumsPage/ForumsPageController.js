({
	salesforceClicked : function(component, event, helper) {
        component.set("v.recentCategory", 'Salesforce');
        
        switch((event.currentTarget.id).toString()){
            case 'salesforce-softskills':
        		component.set("v.recentSubTech", 'Soft Skills');
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
        		component.set("v.recentSubTech", 'Apex');
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
        		component.set("v.recentSubTech", 'Apex Trigger');
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
        		component.set("v.recentSubTech", 'Apex Testing');
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
        		component.set("v.recentSubTech", 'Visualforce');
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
        		component.set("v.recentSubTech", 'Aura/Lightning Components');
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
        		component.set("v.recentSubTech", 'Declarative Salesforce');
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
        		component.set("v.recentSubTech", 'SOQL/SOSL');
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
        		component.set("v.recentSubTech", 'HTML/CSS');
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
        		component.set("v.recentSubTech", 'JavaScript');
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
        component.set("v.recentCategory", 'Java');
                
        switch((event.currentTarget.id).toString()){
            case 'java-softskills':
        		component.set("v.recentSubTech", 'Soft Skills');
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
        		component.set("v.recentSubTech", 'Java');
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
        		component.set("v.recentSubTech", 'React');
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
        		component.set("v.recentSubTech", 'Spring');
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
        		component.set("v.recentSubTech", 'Typescript');
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
        		component.set("v.recentSubTech", 'Node.Js');
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
        		component.set("v.recentSubTech", 'JavaScript');
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
        component.set("v.recentCategory", '.NET');
                
        switch((event.currentTarget.id).toString()){
            case '.net-softskills':
        		component.set("v.recentSubTech", 'Soft Skills');
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
        		component.set("v.recentSubTech", 'C');
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
        		component.set("v.recentSubTech", 'C#');
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
        		component.set("v.recentSubTech", 'C++');
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
        		component.set("v.recentSubTech", 'SQL');
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
        		component.set("v.recentSubTech", 'Python');
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
        		component.set("v.recentSubTech", 'JavaScript');
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
        component.set("v.recentCategory", 'Pop Culture');
                
        switch((event.currentTarget.id).toString()){
            case 'pc-fun':
                component.set("v.recentSubTech", 'C');
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
        let catName = component.get("v.recentCategory");
        let subCatName = component.get("v.recentSubTech");
        
        component.set("v.showQuestionsList", false);
        component.set("v.showQuestion", true);
        let evt = $A.get("e.c:ResponseQuestionEvent");
        evt.setParams({"question_id" : event.currentTarget.id})
        evt.fire();
        
        // Populate the related questions attribute
        let action = component.get("c.getRelatedQuestions");
        action.setParams({categoryName : catName, subCatName : subCatName, rejectedId : event.currentTarget.id})
        action.setCallback(this, function(response){
            var name = response.getState();
            if (name === "SUCCESS") {
                component.set("v.relatedQuestionsList", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }
})