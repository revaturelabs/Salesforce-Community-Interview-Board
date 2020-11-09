({
    setNewValue : function(component, event) {
    	// Retrieve Name, Index, and Value from the event input
        let name = event.getSource().get("v.label");
        let index = parseInt(event.getSource().get("v.name"));
        let newValue = parseInt(event.getSource().get("v.value"));
        
        // Retrieve the Map<String, Integer>, List<Integer>, and List<Object>
        let result = component.get("v.RightSideTypes");
        let displayValue = component.get("v.display");
        
        // If value is higher than max then set to max. If value is less than 1, set to 1.
        // Otherwise set to value.
        if(newValue > displayValue[index]["max"]) {
            result.set(name, parseInt(displayValue[index]["max"]));
            displayValue[index]["number"] = parseInt(displayValue[index]["max"]);
        }else if(newValue < 1) {
            result.set(name, 1);
            displayValue[index]["number"] = 1;
        }else {
            result.set(name, newValue);
            displayValue[index]["number"] = newValue;
        }
       
        // Store results
        component.set("v.RightSideTypes", result);   
        component.set("v.display", displayValue);
	},
    setListValues : function (component, listValues) {
        // Grab the Map<String, Integer> mapping and create new Map and Integer.
        let result = component.get("v.RightSideTypes");
        let newMap = new Map();
        let newInteger = [];
        
        // Iterate through List<String> listValues
        for(let i = 0; i < listValues.length; i++) {
            // If it exist in old Map, then add the value store in old Map to new Map.
            // Otherwise create a new (key, value) pair and store in new Map.
            if(result.get(listValues[i])) {
                newMap.set(listValues[i], result.get(listValues[i]));
            }else {
                newMap.set(listValues[i], 1);
            }
            newInteger.push({
                 name : listValues[i],
                 number : newMap.get(listValues[i]),
                 max : 0
             });
        }
        // Save changes to the attributes
        component.set("v.RightSideTypes", newMap);
		component.set("v.display", newInteger);
        // Refresh display
        this.grabLimit(component);
    },
    grabLimit : function(component) {
        // Call Apex method and send the selected topics.
        let action = component.get("c.getNumberOfQuestionType");
        action.setParams({"filter" : component.get("v.default")});
        action.setCallback(this, function(response) {
            if(response.getState() == "SUCCESS") {
                // Retrieve selected list and response from Apex
                let displayValue = component.get("v.display");
                let results = response.getReturnValue();
                
                // Iterate and update selected list
                for(let i = 0; i < results.length; i++) {
                    displayValue[i]["max"] = results[i];
                    if(results[i] == 0) {
                        displayValue[i]["number"] = 0;
                    }
                }
                
                // Save results to attribute
                component.set("v.display", displayValue);
            }
        });
        $A.enqueueAction(action);
    }
})