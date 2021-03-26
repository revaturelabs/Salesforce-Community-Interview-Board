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
                label: "View",
                type: "button",
                initialwidth: 135,
                typeAttributes: {label: "Get Info",
                                 name: "Get_info",
                                 title: "Click to view Associate"}
            }
		]);
	},
    Search : function(component, event, helper){
        var searchValue = component.find("SField").get("v.value");
        
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
    handleRowAction : function(component, event, helper) {
        var row = event.getParam('row');
        var exEvt = $A.get("e.c:AssociateName");
        exEvt.setParams({"AId": row.Id});
        exEvt.fire();
   }
})