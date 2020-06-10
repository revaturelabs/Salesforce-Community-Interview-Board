//JS STYLE GUIDE
//If unsure, defer to the class style guide
({
	//spaces around :
	//component, event, and helper should only be renamed if 
	//their use is very unclear otherwise
	//lists of Params should have a space after each , 
	doInit : function(component, event, helper){
		//use const first, then let. var should be avoided
		let calloutAction = component.get("c.startCallout");
		
		//only pass functions as params when required by
		//existing system methods
		calloutAction.setCallback(this, function(response){
			const state = response.getState();
			
			//use === over ==
			if(state === "SUCCESS"){
				//logic
			//else blocks should follow if blocks directly inline
			//same with try catch finally
			} else {
				//logic
			}
		});
		
		//similar to returns, any methods that have a final action
		//such as a call to another method should be separate from
		//code above and below
		$A.enqueueAction(calloutAction);
	},
	
	//an empty line between methods
	clickCreate : function(component, event, helper){
		//logic
	}
})