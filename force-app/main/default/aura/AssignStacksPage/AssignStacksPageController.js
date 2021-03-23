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
    
    handleRowAction : function(component, event, helper) {
        var row = event.getParam('row');
        component.set("v.AssoKey", row.Id);
    },
    
    handleRowStackAction : function(component, event, helper) {
        var StackList = [];
        StackList = component.get("v.StacksSelected");
        var row = event.getParam('row');
        StackList.push(row);
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
    }
})