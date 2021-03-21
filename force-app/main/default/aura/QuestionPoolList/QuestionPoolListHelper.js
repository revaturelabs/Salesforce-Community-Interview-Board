({
    doinit : function(component, event) {
        //Set up first table
		component.set("v.questionList", [
            {label: "Question", fieldName:"Body__c", type:"String", wrapText: true},
            {label: "Stack", fieldName:"Stack__c", type:"String"},
            {label: "Type", fieldName:"Type__c", type:"String"},
            {label: "Setting", fieldName:"Setting__c", type:"String"},
            {label: "Locked", fieldName:"Locked__c", type:"boolean"}
        ]);
        
        //Set up second table
        component.set("v.responseList", [
            {label: "Question", fieldName: "QuestionName", type: "String", wrapText: true},            
            {label: "Response", fieldName: "Body__c", type: "String", wrapText: true},
            {label: "Upvotes", fieldName: "Upvotes__c", type: "Number"}
        ]);
        
		//query database and fill table
        this.getData(component, event);
    },
    
    getData : function(component,event) {
        //get questions from database
        var action = component.get("c.getQuestionPool");
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS" ){
                component.set("v.question", response.getReturnValue());           
            }
            else{
                console.log("failed");
            }
        });
        
        $A.enqueueAction(action);
    },
    
    selectQuestion : function(component,event) {
        //get selected row ids from table
        let qList = event.getParam("selectedRows");
        component.set("v.selectedQuestions",qList);
        
        let rowIds = [];
        let rows = component.find('listTable').getSelectedRows();
        
        if(rows.length > 0){
            //prepare string array with all relevant ids
            rows.forEach(rowId => rowIds.push(rowId.Id));
        }
        //query database for response data
        var action = component.get("c.getResponses");
        action.setParams({questionId : rowIds});
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                //assigns the question column value to the table
                var rows = response.getReturnValue();
                for (var i = 0; i < rows.length; i++) {
                   	var row = rows[i];
                    if (row.Question__c){ 
                        row.QuestionName = row.Question__r.Body__c;
                    }
                }
                //assign data to view
                let data = response.getReturnValue();
                component.set('v.response', data);
                
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
        //deletes questions from selected rows
        let selectedRows = component.get("v.selectedQuestions");
        let idList = [];
        
        for(let i=0;i<selectedRows.length;i++){
            idList.push(selectedRows[i].Id);
        }
        let action = component.get("c.deleteQuestions");
        action.setParams({"idList" : idList});
    	action.setCallback(this,function(response){
    		if(response.getState()==="SUCCESS"){
                //$A.get('e.force:refreshView').fire();
                
                //clear selected rows and refresh data
                component.set('v.empty', [] );
                component.set('v.selectedQuestions', null);
                this.getData(component, event);
			}
 		});
    $A.enqueueAction(action);
	},
    
    deleteResponse : function(component, event){
        //deletes responses from selected rows
        let selectedRows = component.get("v.selectedResponses");
        let idList = [];
        
        for(let i=0;i<selectedRows.length;i++){
            idList.push(selectedRows[i].Id);
        }
        
        let action = component.get("c.deleteResponses");
        action.setParams({"idList" : idList});
    	action.setCallback(this,function(response){
    		if(response.getState()==="SUCCESS"){
                //$A.get('e.force:refreshView').fire();
                
                //clear selected rows and refresh data
                
                component.set('v.emptyResponses', [] );
                component.set('v.selectedResponses', null);
                
                this.selectQuestion(component, event);
                
                
			}
            else{
                console.log(response.getState());
            }
 		});
    	$A.enqueueAction(action);
    },
    
    lockResponse : function(component,event) {
        //locks question from recieving any new responses on selected rows
        let selectedRows = component.get("v.selectedQuestions");
        let idList = [];
        for(let i=0;i<selectedRows.length;i++){
            idList.push(selectedRows[i].Id);
        }
        let action = component.get("c.lockQuestions");
        action.setParams({"idList" : idList});
    	action.setCallback(this,function(response){
    		if(response.getState()==="SUCCESS"){
                //$A.get('e.force:refreshView').fire();
                
                //refresh table data
                component.set('v.empty', [] );
                component.set('v.selectedQuestions', null);
                this.getData(component, event);
			}
 		});
    $A.enqueueAction(action);
	}
    
})