({
    //this function is used to fatch value from database and it will display dropdownlist according to selection of SubTech Button
	getvalueForDropdown : function(component,event) {
		
     
        // On the change of event value on button click in harnessApp the below variable will also change the value for this component.
       var ShowResultValue = event.getParam("Pass_Result");
       
       console.log(ShowResultValue);
         component.set("v.Get_Result", ShowResultValue);
         
        var action1=component.get('c.challengeName');
        action1.setParams({recordid:event.getParam("Pass_Result")});
        action1.setCallback(this,function(response){
            console.log(response.getState());
            if(response.getState()==='SUCCESS')
            {
               
                console.log(response.getReturnValue());
                component.set("v.ChallengeItems",response.getReturnValue());
            }
            
       })
         
        $A.enqueueAction(action1);
	},
   
    //this function will retrive the status of the operation from Apex controller on the click of Completed Button click
    challengeCompleteButton : function(component,event) {
	
        var selectCmp = component.find("InputSelectSingle").get("v.value");
        console.log(selectCmp);
       
        console.log('inside complete button');
  
        var action1=component.get('c.challengecompleted');
        action1.setParams({challangeName:selectCmp});
        action1.setCallback(this,function(response){
            console.log(response.getState());
            if(response.getState()==='SUCCESS')
            {
               
                console.log(response.getReturnValue());
                component.set("v.ChallangeCompleteStatus",response.getReturnValue());
            }
            
       })
         
        $A.enqueueAction(action1);
	},
     // On the change of DropDown value below function will also change the Detail value in the component.
    getDropdownValueDetail : function(cmp, event) {
        
        var selectCmp = cmp.find("InputSelectSingle").get("v.value");
        console.log(selectCmp);
       
        var recordId= cmp.get("v.Get_Result");
        console.log(recordId);
         var action1=cmp.get('c.challengeData');
        	action1.setParams({recordid:recordId,
                               ChallangeName:selectCmp});
        	action1.setCallback(this,function(response){
            	console.log(response.getState());
            		if(response.getState()==='SUCCESS')
                    {
               
               		 console.log(response.getReturnValue());
                	 cmp.set("v.ChallengeApexData",response.getReturnValue());
                        cmp.set("v.DisplayDetail",'True');
           		   }
          
      })
         
        $A.enqueueAction(action1);
    }
})