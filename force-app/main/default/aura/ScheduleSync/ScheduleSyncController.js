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
                component.set('v.updateSuccess', true);
                component.set('v.oldHours', hours);
                component.set('v.oldMinutes', minutes);
                component.set('v.oldDayOfWeek', dayOfWeek);
                component.set('v.timeRetrieved', true);
                component.set('v.noJob', false);
            }
            else{
                component.set('v.error', true);
                console.log(response.getState());
            }
        });
        $A.enqueueAction(setSync);       
	},
    getSchedule : function(component, event, helper) {
        let getSync = component.get('c.getCRONExpression');
        
        getSync.setCallback(this, function(response){
            if(response.getState() == 'SUCCESS'){
                let thisTime = response.getReturnValue();
                
                if(thisTime[0] == '-1'){
                    component.set('v.noJob', true);
                }
                else{
                    for(let i = 0; i < 2; i++){
                    if(thisTime[i].length < 2){
                        thisTime[i] = '0' + thisTime[i];
                    	}
                	}
                
                component.set('v.oldHours', thisTime[0]);
                component.set('v.oldMinutes', thisTime[1]);
                component.set('v.oldDayOfWeek', thisTime[2]);
                component.set('v.timeRetrieved', true);
                }
                
            }
            else{
                component.set('v.error', true);
                console.log(response.getState());
                console.log(response.getError());
            }
        });
        $A.enqueueAction(getSync);
    }
})