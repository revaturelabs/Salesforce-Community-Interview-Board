({
    //Sets the batchAccount attribute with a list of all batch Accounts obtained from the apex controller.
    loadBatchAccounts : function(component, event) {
        var batchAction = component.get('c.getBatchAccounts');
        batchAction.setCallback(this, function(response){

            if (response.getState() == "SUCCESS"){
               component.set("v.batchAccounts", response.getReturnValue());
            }
        })
        $A.enqueueAction(batchAction);
    },

    //Sets the clientAccount attribute with a list of all client Accounts obtained from the apex controller.
    loadClientAccounts : function(component, event) {
        var clientAction = component.get('c.getClientAccounts');
        clientAction.setCallback(this, function(response){

            if (response.getState() == "SUCCESS"){
               component.set("v.clientAccounts", response.getReturnValue());
            }
        })
        $A.enqueueAction(clientAction);
    },

    //Once submit button is clicked, this obtains values entered in by user, passes them into the apex controller and submits to database.
    submitRecord : function(component){
    var bId = component.get("v.selectedBatchId");
    var cId = component.get("v.selectedClientId");
    var n = component.get("v.batchClientName");

    var submitAction = component.get("c.createBatchClientObj");
    submitAction.setParams({batchId : bId, clientId : cId, name : n });
    submitAction.setCallback(this, function(response){

        if (response.getState() == "SUCCESS"){
            alert("Sucessfully Created a Batch Client Association!");
            component.set("v.batchClientName", "");    //reset name back to null once successfully submitted
        }

    })
    $A.enqueueAction(submitAction);



    }

})