({
	manualSync : function(component, event, helper) {
        component.set('v.isLoading', true);
        setTimeout(function(){
            component.set('v.isLoading', false);
            component.set('v.isSuccess', true);
        },3000);
	}
})