({
	doInit : function(component, event, helper) {
        helper.loadAssociateList(component, event)
        console.log('Associate List: ' + component.get("v.associateList"))
        component.set("v.columns", [
            					{label : 'Associate Name', fieldName : 'associateName', type : 'String'},
                       			{label: 'Client Name', fieldName : 'clientName', type : 'String'},
            					{label: 'Date Selected', fieldName: 'dateSelected', type : 'Date'}
        ]);
        console.log('Columns set.')
	}
})