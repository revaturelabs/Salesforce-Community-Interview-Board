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
    
    AssignedStack : function(component,event){
        var action1=component.get('c.AssignedStack');
        action1.setCallback(this,function(response){
            console.log(response.getState());
            if(response.getState()==='SUCCESS')
            {
         
                component.set("v.AssignedStack",response.getReturnValue());
            } 
            
       })
        $A.enqueueAction(action1);
    },
    getSubTechScore : function(component,event){
        var action1=component.get('c.getSubTech');
        action1.setCallback(this,function(response){
            console.log(response.getState());
            if(response.getState()==='SUCCESS')
            {
         
               
                //console.log(response.getReturnValue());
                
               var result = response.getReturnValue();
                
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
                
                
               /* var arrayMapKeys = [];
                for(var key in result){
                    arrayMapKeys.push({key: key, value: result[key]});
                }
                 component.set("v.SubTech_Score",arrayMapKeys);
                console.log(arrayMapKeys);
               */
            } 
            
       })
        $A.enqueueAction(action1);
    }
})