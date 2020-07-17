({
launchFlow : function(component, event, helper) {
//handles retrieveing and setting the id of the mock interview, then binding and launching the flow
            component.set("v.MockId", event.getParam("MockId"));
            var meetid = component.get("v.MockId");
            console.log(meetid);
            var flow = component.find("MockInterviewFlow");

        //Put input variable values
        var inputVariables = [
            {
                name : "meetingid",
                type : "String",
                value : meetid
            }
        ];

        //Reference flow's Unique Name
        flow.startFlow("Mock_Interview_Flow", inputVariables);
    } ,

    onmodalclose : function(component, event, helper) {
        //called when the modal window is closed
        //component.set("v.isModalOpen", false);
        helper.onmodalclosehelper(component, event);
      //  var e = component.getEvent("FlowClose");
      //  console.log("Firing onmodalclose")
       // e.setParams({"FlowClose" : true }); 
       // e.fire(); 
    },

    onstatuschange : function(component, event, helper) {
        //called every time the flow changes status, but the conditional only runs when its complete. 
        console.log("status change");
        if (event.getParam('status') === "FINISHED_SCREEN" || event.getParam('status') === "FINISHED") {
			helper.onmodalclosehelper(component, event);
			console.log("finished");
            //$A.get("e.force:closeQuickAction").fire();
           // $A.get('e.force:refreshView').fire();
        }
    },
})