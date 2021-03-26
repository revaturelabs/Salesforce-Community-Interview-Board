({
	manualSync : function(component, event, helper) {
        component.set('v.isLoading', true);
        let startTime = new Date();
        startTime = startTime.getTime();
        
        let updateNow = component.get('c.updateFromAura');
        updateNow.setCallback(this, function(response){
            let updateCounts = response.getReturnValue();
            
            if(updateCounts[0] == '-1' || updateCounts[1] == '-1'){
                component.set('v.isLoading', false);
                component.set('v.isError', true);
            }
            else{
                let endTime = new Date();
                endTime = endTime.getTime();
                
                let totalTime = endTime - startTime;
                totalTime = totalTime/1000;
                console.log(totalTime);
                
                component.set('v.batches', String(updateCounts[0]));
                component.set('v.associates', String(updateCounts[1]));
                component.set('v.time', totalTime);
                component.set('v.isLoading', false);
                component.set('v.isSuccess', true);
            }
            
            
        });
        $A.enqueueAction(updateNow);
	}
})