({
	handleUserImg:function(component, event){
        console.log("activate")
         var imageUrl = component.get("v.UserImg");

		var img = component.find("img")
         var actionTwo = component.get("c.ActiveUserImg");
        // Add callback behavior for when response is received
        actionTwo.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
               component.set("v.UserImg", response.getReturnValue());
               var imageUrl = component.get("v.UserImg");
               var newMapAttributes = {"src": response.getReturnValue()};
			component.find("imgDiv").set("v.HTMLAttributes",newMapAttributes);

            }
            else {
                console.log("Failed with state: " + state);
              
            }
        });
        // Send action off to be executed
        $A.enqueueAction(actionTwo); 
     }
})