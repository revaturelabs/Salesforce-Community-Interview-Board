({
    doinit : function(component, event, helper) {
        component.set("v.questionList", [
            {label: "Name", fieldName:"Name", type:"String"},
            {label: "Type", fieldName:"Subject__c", type:"String"},
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
    }
})

