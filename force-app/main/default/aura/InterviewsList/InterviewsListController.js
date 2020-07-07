({
    doinit : function(component, event, helper) {
        component.set("v.interviewList", [
            {label: "Interviewer", fieldName:"Client_Name__c", type:"String"},
            {label: "Location", fieldName:"Location__c", type:"String"},
            {label: "Time", fieldName:"Scheduled__c", type:"Date/Time"}
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
