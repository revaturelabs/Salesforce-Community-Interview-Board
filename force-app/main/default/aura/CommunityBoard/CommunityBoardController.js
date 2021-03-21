({
	doInit : function(component, event, helper) {
        let associateList = helper.loadAssociateList(component, event)
        component.set("v.columns", [
            					{label : 'Associate Name', fieldName : 'Name', type : 'String'},
                       			{label: 'Client Name', fieldName : 'Client__c', type : 'String'}
        ]);
	}
})