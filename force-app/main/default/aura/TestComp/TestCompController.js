({
	onClick : function(component, event, helper) {

        let info = component.get("{!c.CreateEvent}");
        info.setCallback(this, function(response){
            let id= response.getReturnValue();
            component.set("v.G_Event_Id", id);
        });
        $A.enqueueAction(info);
	},
    
    handleOnSubmit : function(component, event, helper) { 
    
    	var action = component.get('{!c.createEvent}');
        
        let sumMeet = component.find('Name').get('v.value');
        let startDateMeet = component.find('StartAvailability').get('v.value');
        let endDateMeet = component.find('EndAvailability').get('v.value');
        
        console.log(sumMeet);
        console.log(endDateMeet);
        console.log(startDateMeet);
        
        action.setParams({sum: sumMeet,
                          endDate: endDateMeet,
                          startDate: startDateMeet});
        action.setCallback(this, function(response){
            console.log('blah');
            
        })
        
        $A.enqueueAction(action);
        
    }
    
})