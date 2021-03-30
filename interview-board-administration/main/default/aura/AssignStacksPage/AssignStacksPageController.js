({
	init: function(component, event, helper) {
        //var actions = helper.getrowactions.bind();
		component.set("v.columns", [
			{
				label: "Associate Name",
				fieldName: "Name",
				type: "String"
			},
            {
                label: "Select",
                type: "button",
                initialwidth: 135,
                typeAttributes: {label: "Select Associate",
                                 name: "Select_Associate",
                                 title: "Click to select Associate"}
            }
		]);
        
        component.set("v.stackColumns", [
			{
				label: "Stack Name",
				fieldName: "Name",
				type: "String"
			},
            {
                label: "Select",
                type: "button",
                initialwidth: 135,
                typeAttributes: {label: "Select Stack",
                                 name: "Select_Stack",
                                 title: "Click to select Stack"}
            }
		]);

        component.set("v.stackColumnsSelected", [
			{
				label: "Stack Name",
                 fieldName: "Name",
				type: "String"
			},
            {
                label: "Delete",
                type: "button",
                initialwidth: 135,
                typeAttributes: {label: "Delete Stack",
                                 name: "Delete_Stack",
                                 title: "Click to delete Stack"}
            }
		]);
        
        component.set("v.batchColumns", [
			{
				label: "Batch Name",
        fieldName: "Name",
				type: "String"
			},
            {
                label: "Select",
                type: "button",
                initialwidth: 135,
                typeAttributes: {label: "Select Batch",
                                 name: "Select_Batch",
                                 title: "Click to select Batch"}
            }
		]);
	},
    
    Search : function(component, event, helper){
        //var searchValue = component.find("SField").get("v.value");
        
        var action = component.get("c.AssociateSearch");
        action.setParams({AName: component.get("v.SKey")});
        action.setCallback(this, $A.getCallback(function (response) {
            
            switch (response.getState()) {
                case "SUCCESS":
                    // Populate table with values
                    component.set("v.Associate", response.getReturnValue());
                    break;
            }
        }));
        
        $A.enqueueAction(action);
    },
    
    SearchStack : function(component, event, helper){
        //var searchValue = component.find("SField").get("v.value");
        
        var action = component.get("c.StackSearch");
        action.setParams({SName: component.get("v.SStaKey")});
        action.setCallback(this, $A.getCallback(function (response) {
            
            switch (response.getState()) {
                case "SUCCESS":
                    // Populate table with values
                    component.set("v.Stacks", response.getReturnValue());
                    break;
            }
        }));
        
        $A.enqueueAction(action);
    },
    
    SearchBatch : function(component, event, helper){
        //var searchValue = component.find("SField").get("v.value");
		console.log('Here in searchBatch!!!');
        var action = component.get("c.BatchSearch");
        action.setParams({SName: component.get("v.SBatKey")});
        action.setCallback(this, $A.getCallback(function (response) {
            console.log(response.getState());
            switch (response.getState()) {
                case "SUCCESS":
                    // Populate table with values
                    component.set("v.Batches", response.getReturnValue());
                    break;
            }
        }));
        $A.enqueueAction(action);
    },
    
    handleRowAction : function(component, event, helper) {
        var row = event.getParam('row');
        component.set("v.AssoKey", row.Id);
    },
    
    handleRowStackAction : function(component, event, helper) {
        var StackList = [];
        var dontPush = false;
        StackList = component.get("v.StacksSelected");
        var row = event.getParam('row');

        for(let item of StackList){
            if(item.Name == row.Name){
                dontPush = true;
            }
        }
        
        if(!dontPush){
            StackList.push(row);
        }

        component.set("v.StacksSelected", StackList);
    },

    handleRowRemoveAction : function(component, event, helper) {
        var StackList = [];
        StackList = component.get("v.StacksSelected");
        var row = event.getParam('row');
        var index = StackList.indexOf(row);
        StackList.splice(index, 1);
        component.set("v.StacksSelected", StackList);
    },
    
    handleRowBatchAction : function(component, event, helper) {
        var row = event.getParam('row');
        component.set("v.BatKey", row.Id);
    },
    
    AssignStack : function(component, event, helper) {
        console.log("entered assign method");
        var stacks = component.get("v.StacksSelected");
        var assocID = component.get("v.AssoKey");
        console.log(stacks + " " + assocID);
        if(stacks != null && assocID != null){
            helper.assignMethod(component);
        } else{
            component.set("v.Notification","Select an Associate and a Stack!");
        }
    },
   
    AssignStackToBatch : function(component, event, helper) {
        console.log("entered assign method");
        var stacks = component.get("v.StacksSelected");
        var batchID = component.get("v.BatKey");
        console.log(stacks + " " + batchID);
        if(stacks != null && batchID != null){
            helper.assignMethodBatch(component);
        } else{
            component.set("v.Notification","Select a Batch and a Stack!");
        }
    }
})