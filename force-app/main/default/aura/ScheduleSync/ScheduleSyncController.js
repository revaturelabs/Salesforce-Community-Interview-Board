({
	updateSchedule : function(component, event, helper) {
		let setSync = component.get('c.setCRONExpression');
        
        let hours = component.get('v.Hours');
        let minutes = component.get('v.Minutes');
        let dayOfWeek = component.get('v.DayOfWeek');
        let cronExp = '0 ' + minutes + ' ' + hours + ' ' + '? * ' + dayOfWeek + ' *';
        
        setSync.setParams({newCRON: cronExp});
        setSync.setCallback(this, function(response){
            if(response.getState() == 'SUCCESS'){
                helper.fetchSchedule(component, event, helper);
                component.set('v.updateSuccess', true);
                component.set('v.noJob', false);
            }
            else{
                component.set('v.error', true);
                console.log(response.getState());
            }
        });
        $A.enqueueAction(setSync);       
	},
    getSchedule : function(component, event, helper){
        helper.fetchSchedule(component, event, helper);
    }
})