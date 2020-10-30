({
	transformData : function(component){
        let reportIdsList = component.get("v.default");
        let reportNamesList = component.get("v.numberOfQuestions");
        let result = [];
         for(let i = 0; i< reportIdsList.length; i=i+1){
             result.push({
                 name : reportIdsList[i],
                 number : reportNamesList[i],
                 max : 0
             });
         }
        console.log(result);
        component.set("v.display", result);
        this.grabLimit(component);
    },
    setNewValue : function(component, event) {
    	// Retrieve Name, Index, and Value from the input
        let name = event.getSource().get("v.label");
        let index = parseInt(event.getSource().get("v.name"));
        let newValue = parseInt(event.getSource().get("v.value"));
        
        // Retrieve the Map<String, Integer> and List<Integer>
        let result = component.get("v.RightSideTypes");
        let numberOfQuestions = component.get("v.numberOfQuestions");
        let displayValue = component.get("v.display");
        
        // If number is lower than 1, set it to 1.
        if(newValue < 1) {
            numberOfQuestions[index] = 1;
        }else if(newValue < displayValue[index]["max"]){
            numberOfQuestions[index] = newValue;
        }else {
            numberOfQuestions[index] = displayValue[index]["max"];
        }
        
        // Store results
        result.set(name, parseInt(numberOfQuestions[index]));
        component.set("v.numberOfQuestions", numberOfQuestions);
        component.set("v.RightSideTypes", result);
        
        // Refresh display
        this.transformData(component);
	},
    setListValues : function (component, listValues) {
        let result = component.get("v.RightSideTypes");
        let newMap = new Map();
        let newInteger = [];
        // Iterate through value from selection and add changes based on value.
        // If old value from map remains, save their number to new map or set to 0.
        for(let i = 0; i < listValues.length; i++) {
            if(result.get(listValues[i])) {
                newMap.set(listValues[i], result.get(listValues[i]));
            }else {
                newMap.set(listValues[i], 1);
            }
            newInteger.push(newMap.get(listValues[i]));
        }
        component.set("v.RightSideTypes", newMap);
		component.set("v.numberOfQuestions", newInteger);
        // Refresh display
        this.transformData(component);
    },
    grabLimit : function(component) {
        let action = component.get("c.getNumberOfQuestionType");
        action.setParams({"filter" : component.get("v.default")});
        action.setCallback(this, function(response) {
            if(response.getState() == "SUCCESS") {
                let displayValue = component.get("v.display");
                let results = response.getReturnValue();
                for(let i = 0; i < results.length; i++) {
                    displayValue[i]["max"] = results[i];
                }
                component.set("v.display", displayValue);
            }
        });
        $A.enqueueAction(action);
    }
})