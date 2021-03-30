({
    createList : function(component) {
        component.set("v.interviewList", [
            {label: "Mock Interview", fieldName:"Name", type:"String"},
            {label: "Your Notes", fieldName:"Notes__c", type:"String"}
        ]);
        var action = component.get("c.getInterviews");
        //action.setParams();
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS" ){
                component.set("v.interview", response.getReturnValue());
                console.log(response.getReturnValue());
                
            }
            else{
                console.log("failed");
            }
        });
        $A.enqueueAction(action);

    }
})