({
    doinit : function(component, event) {
        //Set up first table
		component.set("v.questionList", [
            {label: "Question", fieldName:"Body__c", type:"String", wrapText: true},
            {label: "Stack", fieldName:"Stack__c", type:"String"},
            {label: "Type", fieldName:"Type__c", type:"String"}
        ]);
        
        //Set up second table
        component.set("v.responseList", [
            {label: "Response", fieldName: "Body__c", type: "String", wrapText: true},
            {label: "Upvotes", fieldName: "Upvotes__c", type: "Number"}
        ]);
        
        var action = component.get("c.getQuestionPool");
        //action.setParams();
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS" ){
                component.set("v.question", response.getReturnValue());
                //console.log(response.getReturnValue());
                
            }
            else{
                console.log("failed");
            }
        });
        
        $A.enqueueAction(action);
    },
    select : function(component,event) {
        //get selected row ids from table
        let qList = event.getParam("selectedRows");
        component.set("v.selectedQuestions",qList);
        
        //get ids from list
        let selectedRows = component.get("v.selectedQuestions");
        let idList = [];
        
        for(let i=0;i<selectedRows.length;i++){
            idList.push(selectedRows[i].Id);
        }
        
        //query database for response data
        var action = component.get("c.getResponses");
        action.setParams({questionId : idList});
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                //assign data to view
                let data = response.getReturnValue();
                component.set('v.response', data);
                
                //DEBUG
                //console.log("Select method Success");
                //console.log(data);
            }
            else{
                console.log("Error calling apex method: getResponses");
                console.log(state);
            }
        });
        $A.enqueueAction(action);
    },
    
    selectResponse : function(component, event) {
        //get selected row ids from table
        let rList = event.getParam("selectedRows");
        component.set("v.selectedResponses", rList);
    },
    
    deleteButton : function(component,event) {
        //let selectedRows =event.getParam("selectedRows");
        let selectedRows = component.get("v.selectedQuestions");
        let idList = [];
        //console.log(selectedRows);
        
        for(let i=0;i<selectedRows.length;i++){
            idList.push(selectedRows[i].Id);
        }
        let action = component.get("c.deleteQuestions");
        action.setParams({"idList" : idList});
    	action.setCallback(this,function(response){
    		if(response.getState()==="SUCCESS"){
                $A.get('e.force:refreshView').fire();
			}
 		});
    $A.enqueueAction(action);
	},
    
    deleteResponse : function(component, event){
        console.log("Start delete response");
        let selectedRows = component.get("v.selectedResponses");
        let idList = [];
        
        for(let i=0;i<selectedRows.length;i++){
            idList.push(selectedRows[i].Id);
        }

		console.log(idList);
        
        let action = component.get("c.deleteResponses");
        action.setParams({"idList" : idList});
    	action.setCallback(this,function(response){
            console.log("Callback started");
    		if(response.getState()==="SUCCESS"){
                console.log("Success entered");
                $A.get('e.force:refreshView').fire();
			}
            else{
                console.log(response.getState());
            }
 		});
    	$A.enqueueAction(action);
    }
})