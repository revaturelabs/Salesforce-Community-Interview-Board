({
	fetchSchedule : function(component, event, helper) {
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

					let timeZone = thisTime[3];
                    timeZone = timeZone.split(' (');
                    
                    if(thisTime[1] == '24'){
                        thisTime[1] = '00';
                    }
                    
                component.set('v.oldMinutes', thisTime[0]);
                component.set('v.oldHours', thisTime[1]);
                component.set('v.oldDayOfWeek', thisTime[2]);
                component.set('v.timeZone', ' ' + timeZone[0]);
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