({
    doinit : function(component, event, helper) {
        component.set("v.questionList", [
            {label: "Name", fieldName:"Name", type:"String"},
            {label: "Type", fieldName:"Type__c", type:"String"},
            {label: "Stack", fieldName:"Stack__c", type:"String", wrapText: true},
            {label: "Question", fieldName:"Body__c", type:"String", wrapText: true}
        ]);
        var action = component.get("c.getQuestionPool");
        //action.setParams();
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS" ){
                component.set("v.question", response.getReturnValue());
                console.log(response.getReturnValue());
                
            }
            else{
                console.log("failed");
            }
        });
        $A.enqueueAction(action);
    },
    select : function(component,event,helper) {
        let qList = event.getParam("selectedRows");
        component.set("v.selectedQuestions",qList);
        console.log(qList);
    },
    
    
    deleteButton : function(component,event,helper) {
        //let selectedRows =event.getParam("selectedRows");
        let selectedRows = component.get("v.selectedQuestions");
        let idList = [];
        console.log(selectedRows);
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
	}
    
})