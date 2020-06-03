({
    //Initial population of Meetings. Passes to a helper functions.
    init : function(component, event, helper) {
        helper.loadMeetings(component);
    },
    
    //Create an InterviewQuestion record from user's input: subject and body
    inputQuestion : function(component, event, helper) {
        //Retrieve the subject and question that was submitted by the user
        var sub = component.get("v.subject");
        var quest = component.get("v.question");
        var meet = component.get("v.selectedMeetingId");
        
        //Subject is null
        if(sub == null){
            alert("Please enter in value in subject");
        //Question is null
        } else if(quest == null) {
            alert("Please enter in values in body");
        //Save to database
        } else{
            helper.saveQuestionHelper(component, sub, quest, meet);
        } 
    },

    //Set selectedMeetingId attribute with the Id of the meeting the user selected from the dropdown menu
    meetingChange : function (component, event, helper) {
        component.set("v.selectedMeetingId",component.find("meetingPicker").get("v.value"));
    }
             
            
})