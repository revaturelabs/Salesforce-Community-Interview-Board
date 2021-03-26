({
    //Initial population of batch and client accounts. Passes to a helper functions.
    init : function(component, event, helper) {
        helper.loadBatchAccounts(component);
        helper.loadClientAccounts(component);
        

    },

    //Set selectedBatchId attribute with the Id of the batch account the user just selected from the dropdown menu
    batchChange : function (component, event, helper) {
        component.set("v.selectedBatchId",component.find("batchPicker").get("v.value"));
    },

    //Set selectedClientId attribute with the Id of the client account the user just selected from the dropdown menu
    clientChange : function (component, event, helper) {
        component.set("v.selectedClientId",component.find("clientPicker").get("v.value"));
    },

    //Handles the submit button. Handles some user input validation before passing to a helper. 
    submitBtn : function (component, event, helper) {
        if ((component.get("v.batchClientName") == null) || (component.get("v.batchClientName") == "")) {
            alert("Please enter a name for this association")
        }else if(component.find("clientPicker").get("v.value") == "evilvalue" && component.find("batchPicker").get("v.value") == "evilvalue"){
            alert("Please select from both fields")
        }else if(component.find("clientPicker").get("v.value") == "evilvalue"){
            alert("Please select a valid Client")
        }else if(component.find("batchPicker").get("v.value") == "evilvalue"){
            alert("Please select a valid Batch")
        } else {
            helper.submitRecord(component);
        }
    
    }
   
})