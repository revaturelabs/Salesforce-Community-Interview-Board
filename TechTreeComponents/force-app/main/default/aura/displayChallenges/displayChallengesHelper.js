({
    challengeCompleteButton : function(component) {
	
        //var selectCmp = component.find("InputSelectSingle").get("v.value");
        //console.log(selectCmp);
       
        //console.log('inside complete button');
  
        var action1=component.get('c.challengecompleted');
        action1.setParams({challangeName:selectCmp});
        action1.setCallback(this,function(response){
            console.log(response.getState());
            if(response.getState()==='SUCCESS') {   
                console.log(response.getReturnValue());
                component.set("v.ChallangeCompleteStatus",response.getReturnValue());
            }
            
       })
         
        $A.enqueueAction(action1);
    }
})
