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
        
    },
    
    handleUpdate : function(component, event, helper) {
        
        var action = component.get('{!c.updateEvent}');
        
        let editSumMeet = component.find('editName').get('v.value');
        let editStartDateMeet = component.find('editStartAvailability').get('v.value');
        let editEndDateMeet = component.find('editEndAvailability').get('v.value');
        let editEID = component.find('EID').get('v.value');

        
        console.log(editSumMeet);
        console.log(editStartDateMeet);
        console.log(editEndDateMeet);
        console.log(editEID);

        
        action.setParams({editSum: editSumMeet,
                          editEndDate: editEndDateMeet,
                          editStartDate: editStartDateMeet,
                          editEID : editEID});
        action.setCallback(this, function(response){
            console.log('blah');
            
        })
        
        $A.enqueueAction(action);
    }
    
})