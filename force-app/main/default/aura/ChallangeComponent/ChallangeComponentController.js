({
	myAction : function(component, event, helper) {
        helper.challengeCompleteButton(component,event);
         component.set("v.DisplayResult",'True');
	},

    onChange : function(component, event, helper) {
		helper.getvalueForDropdown(component,event);
        component.set("v.DisplayPicklist",'True');
	
	},


    getDropdownValue : function(cmp, event,helper) {
        
        cmp.set("v.DisplayResult",'False');
        cmp.set("v.ChallangeCompleteStatus",'');
        helper.getDropdownValueDetail(cmp,event);
       
    }
})