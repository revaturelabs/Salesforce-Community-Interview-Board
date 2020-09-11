({
    //this function will get username on init of component
	Username : function(component,event) {
        var action1=component.get('c.Username');
        action1.setCallback(this,function(response){
            if(response.getState()==='SUCCESS')
            {
                component.set("v.UserName",response.getReturnValue());
            }  
       })
        $A.enqueueAction(action1);
        
	},
    //this function is geting stack name and Score from getstackTech method in Apex Controller
    StackScore : function(component,event){
         var action1=component.get('c.getstackTech');
        action1.setCallback(this,function(response){
            console.log(response.getState());
            if(response.getState()==='SUCCESS')
            {
              //console.log(response.getReturnValue());
                var arrayMapKeys = [];
                //Store the response of apex controller (return map)     
                var result = response.getReturnValue();
                //Set the store response[map] to component attribute, which name is map and type is map.   
                component.set('v.companyMap', result);
                 
                for (var key in result) {
                    arrayMapKeys.push(key);
                }
                //Set the list of keys.     
                component.set('v.keyList', arrayMapKeys);
            } 
            
       })
        $A.enqueueAction(action1);
    },
    //this function is geting Primary Tech name and Score from getPrimaryTech method in Apex Controller
    PrimaryTechscore : function(component,event){
         var action1=component.get('c.getPrimaryTech');
        action1.setCallback(this,function(response){
            console.log(response.getState());
            if(response.getState()==='SUCCESS')
            {
              //console.log(response.getReturnValue());
                var arrayMapKeys = [];
                //Store the response of apex controller (return map)     
                var result = response.getReturnValue();
                //Set the store response[map] to component attribute, which name is map and type is map.   
                component.set('v.companyMap2', result);
                 
                for (var key in result) {
                    arrayMapKeys.push(key);
                }
                //Set the list of keys.     
                component.set('v.keyList2', arrayMapKeys);
            } 
            
       })
        $A.enqueueAction(action1);
    },
     //this function is geting Sub Tech name and Score from getSubTech method in Apex Controller
    getSubTechScore : function(component,event){
        var action1=component.get('c.getSubTech');
        action1.setCallback(this,function(response){
            console.log(response.getState());
            if(response.getState()==='SUCCESS')
            {
              // console.log(response.getReturnValue());
                var arrayMapKeys = [];
                //Store the response of apex controller (return map)     
                var result = response.getReturnValue();
                //Set the store response[map] to component attribute, which name is map and type is map.   
                component.set('v.companyMap3', result);
                 
                for (var key in result) {
                    arrayMapKeys.push(key);
                }
                //Set the list of keys.     
                component.set('v.keyList3', arrayMapKeys);
               
            } 
            
       })
        $A.enqueueAction(action1);
    }
})