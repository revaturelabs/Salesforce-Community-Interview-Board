({
    //Initial population of Meetings. Passes to a helper functions.
    init : function(component, event, helper) {
        helper.loadMeetingsAndTypeMap(component);
    },
    
    //Create an InterviewQuestion record from user's input: subject and body
    inputQuestion : function(component, event, helper) {
        //Retrieve the subject and question that was submitted by the user
        var sub = component.get("v.subject");
        var quest = component.get("v.question");
        var meet = component.get("v.selectedMeetingId");
        var type = component.get("v.questionType");
        var stack = component.get("v.questionStack");
        
        //Subject is null
        if(sub == null){
            alert("Please enter in value in subject");
            //Question is null
        } else if(quest == null) {
            alert("Please enter in values in body");
            //Question is null
        } else if(type == null) {
            alert("Please select a value for type");
            //Question is null
        } else if(stack == null) {
            alert("Please select a value for stack");
            //Save to database
        } else{
            helper.saveQuestionHelper(component, sub, quest, type, stack, meet);
        } 
    },
    
    //Set selectedMeetingId attribute with the Id of the meeting the user selected from the dropdown menu
    meetingChange : function (component, event, helper) {
        component.set("v.selectedMeetingId",component.find("meetingPicker").get("v.value"));
    },
    
    changeTypes : function (component,event,helper) {
        component.set("v.DisplayList", true);
        var selectedStack = component.get("v.questionStack");
        var stackTypeMap = component.get("v.typeMap");
        var typeList = [];
        var tempList = [];
        if(selectedStack.indexOf('--NONE SELECTED--') == -1) {
            tempList = stackTypeMap[selectedStack];
            if (selectedStack) {
                for(let type of tempList) typeList.push(type);
                
                component.set("v.availableTypes", typeList);
            }
            component.set("v.DisplayList", true);
        } else {
            component.set("v.DisplayList", false);
        }
    }         
    
})