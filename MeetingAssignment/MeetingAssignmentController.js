({
    myAction : function(component, event, helper) {
        var meetingName = component.find("meetingName").get("v.value");
        var location = component.find("location").get("v.value");
        var notes = component.find("notes").get("v.value");
        var scheduled = component.find("scheduled").get("v.value");
        var completed = component.find("completed").get("v.value");
        var recordType = component.find("recordType").get("v.value");
        
    }
})
