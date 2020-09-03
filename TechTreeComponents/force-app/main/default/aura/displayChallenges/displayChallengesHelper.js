({
    challengeCompleteButton : function(component,chalId) {
	
        //var selectCmp = component.find("InputSelectSingle").get("v.value");
        //console.log(selectCmp);
       
        //console.log('inside complete button');
  
        var action1=component.get('c.chalComp');
        action1.setParams({chalId:JSON.stringify(chalId)});
        action1.setCallback(this,function(response){
            console.log(response.getState());
            if(response.getState()==='SUCCESS') {
                component.set("v.ChallangeCompleteStatus","Successful");
            }
            
       });
        $A.enqueueAction(action1);
    }
})
