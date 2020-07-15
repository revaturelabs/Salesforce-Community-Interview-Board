({
launchFlow : function(component, event, helper) {

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
        //component.set("v.isModalOpen", false);
        helper.onmodalclosehelper(component, event);
      //  var e = component.getEvent("FlowClose");
      //  console.log("Firing onmodalclose")
       // e.setParams({"FlowClose" : true }); 
       // e.fire(); 
    },

    onstatuschange : function(component, event, helper) {
        
        console.log("status change");
        if (event.getParam('status') === "FINISHED_SCREEN" || event.getParam('status') === "FINISHED") {
			helper.onmodalclosehelper(component, event);
			console.log("finished");
            //$A.get("e.force:closeQuickAction").fire();
           // $A.get('e.force:refreshView').fire();
        }
    },
})