({
    //upon init, use the getAll Apex method
    doInit : function(component, event, helper) {
        var action = component.get("c.getAll");
        //set yer callback. in this case, we unpack the
        //result (objs from Apex getAll method)
        //to populate the picklists for the user.
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS")
            {
                var results = response.getReturnValue();
                component.set("v.interviewers", results[0]);
                component.set("v.associates", results[1]);
                component.set("v.batches", results[2]);
                helper.ascMap(component);
            }
        });
        $A.enqueueAction(action);
    },

    clickCreate : function(component, event, helper) {
        //grey out Create button as soon as it's clicked
        component.set("v.buttonStatus",true);

        //get all the things from the view
        var meet = component.get("v.meeting");
        var entireBatch = component.get("v.allbatch");
        var batch = component.get("v.meeting.Batch__c");
        var interviewer = component.get("v.selInterviewer");
        var associate = null;

        //if it's not an entire batch selected, get the selected associate
        if(!entireBatch)
            associate = component.get("v.selAssociate");
        
        //check for issues
        console.log(batch + " " + interviewer + " " + associate);
        //call the createMeeting Apex method
        var action = null;

        if(entireBatch)
        {
            action = component.get("c.createMeetingAllBatch");
            action.setParams({
                meeting : meet,
                //strBatch : batch,
                strInterviewer : interviewer,
                fullBatch : component.get("v.ascbatchmap")[batch]
            });
            console.log(component.get("v.ascbatchmap"));
        }
        else
        {
            action = component.get("c.createMeeting");
            action.setParams({
                meeting : meet,
                strInterviewer : interviewer,
                strAssociate : associate
            });
        }
        
        //set yer callback
        action.setCallback(this,function(response){
            var state = response.getState();
           
            //check for issues
            console.log(state);
            
            if(state === "SUCCESS")
            {
                var meeting = response.getReturnValue();
                //show success message if meeting is created
                if(meeting!=null)
                {
                    component.set("v.buttonLabel","Meeting Created!");
                    setTimeout(function(){
                        component.set("v.buttonLabel","Create Meeting");
                        component.set("v.buttonStatus",false);
                    },2000);
                    helper.showToast(true);
                }
                else
                {
                    component.set("v.buttonLabel","Creation Failed!");
                    setTimeout(function(){
                        component.set("v.buttonLabel","Create Meeting");
                        component.set("v.buttonStatus",false);
                    },2000);
                    helper.showToast(false);
                }
                    

                
                //reset form
                component.set("v.meeting", {"sObject":"Meeting__c"});
                component.set("v.selInterviewer", "");
                component.set("v.meeting.Batch__c", "");
                component.set("v.selAssociate", "");
                
            }
            
            
        });
        $A.enqueueAction(action);
    },

    //Called when Batch picklist is changed
    updateAssociates : function(component, event, helper) {
        
        var accid = event.getSource().get("v.value");
        component.set("v.batchAssociates", component.get("v.ascbatchmap")[accid]);
    },

    //whatever component wants this event needs to handle it, probably the meeting tiles or meeting assignment
    throwTheMeeting : function(component, event, helper) {
            var throwMeeting = component.getEvent("throwMeeting");
            //throwMeeting.setParams
            //throwMeeting.fire();
    }
})