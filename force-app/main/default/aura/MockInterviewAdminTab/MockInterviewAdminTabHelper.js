({
    fetchmeetingsHelper : function(component, event, helper) {
    var action = component.get("c.GetUpcomingMeetingsAll");
    action.setCallback(this, function(response){
        var state = response.getState();
       if (state === "SUCCESS") {
           console.log('SUCCESS')
            var rows = response.getReturnValue();
               rows.forEach(function(rows){
                rows.linkName = '/'+rows.Id;
            });
            console.log(rows)
            component.set("v.data", rows);
        } else {
            let errors = response.getError();
            let message = 'Unknown error'; // Default error message
            // Retrieve the error message sent by the server.
            if (errors && Array.isArray(errors) && errors.length > 0) {
                message = errors[0].message;
            }
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": "ERROR!",
                "message": message, 
                "type" : 'error'
            });
            toastEvent.fire();
        }
    });
    $A.enqueueAction(action);
},

attachQuestions : function(component, event, helper) {
        //deletes questions from selected rows
        let selectedRows = component.get("v.selectedQuestions");
        let idList = [];
        
        for(let i=0;i<selectedRows.length;i++){
            idList.push(selectedRows[i].Id);
        }
        let action = component.get("c.attachQuestionsToMeeting");
        console.log(idList)
        console.log(component.find("meetingSelect").get("v.value"))
        action.setParams({"idList" : idList, "meeting" : component.find("meetingSelect").get("v.value")});
    	action.setCallback(this,function(response){
            console.log(response.getError())
    		if(response.getState()==="SUCCESS"){
                console.log('SUCCESS')
                helper.showToast(true)
                //$A.get('e.force:refreshView').fire();
                
                //clear selected rows and refresh data
                component.set('v.empty', [] );
                component.set('v.selectedQuestions', null);
                this.getData(component, event);
			}
 		});
    $A.enqueueAction(action);
	},

    showToast : function(success) {
        try{
            var toastEvent = $A.get("e.force:showToast");
            if(success)
            {
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "The questions have been added to the meeting successfully.",
                    "type":"success"
                });
            }
            else
            {
                toastEvent.setParams({
                    "title": "Creation Failed!",
                    "message": "The record creation failed.",
                    "type":"error"
                });
            }
            toastEvent.fire();
        } catch(err) {}
    }
})