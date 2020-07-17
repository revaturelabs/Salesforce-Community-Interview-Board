({
    doinit : function(component, event, helper) {
        //setup colums for data table 
        component.set("v.questionList", [
            {label: "Question", fieldName:"Body__c", type:"String", wrapText: true},
            {label: "Type", fieldName:"Type__c", type:"String"},
            {label: "Stack", fieldName:"Stack__c", type:"String", wrapText: true}
            
        ]);
        //bind to the apex contorller method
        var action = component.get("c.getQuestionPool");
        action.setParams({"parentid" : component.get("v.parentid")});
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS" ){
                
                
                 
                var rows = response.getReturnValue();
                //assign values to the rows in the 
            for (var i = 0; i < rows.length; i++) {
                var row = rows[i];
                if (row.Question__c)
                {
                    row.Name = row.Question__r.Name
                    row.Type__c = row.Question__r.Type__c;
                    row.Stack__c = row.Question__r.Stack__c;
                    row.Body__c = row.Question__r.Body__c;
                }
            }
               //assign the vales of rows to the question data array 
                
            component.set('v.question', rows);
            
                
                
                
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
        //gets a list of selected rows from the aura attribute
        let selectedRows = component.get("v.selectedQuestions");
        let idList = [];
        console.log(selectedRows);
        for(let i=0;i<selectedRows.length;i++){
            idList.push(selectedRows[i].Id);
        }
        //binds to deleteQuestions method in the apex controller, executes method. 
        let action = component.get("c.deleteQuestions");
        action.setParams({"idList" : idList});
        action.setCallback(this,function(response){
            if(response.getState()==="SUCCESS"){
                $A.get('e.force:refreshView').fire();
            }
        });
        $A.enqueueAction(action);
    },
    
    
    isRefreshed: function(component, event, helper) {
        location.reload();
    }
    
})