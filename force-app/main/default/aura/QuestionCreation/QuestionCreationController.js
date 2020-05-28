({
    //Create an InterviewQuestion record from user's input: subject and body

    inputQuestion : function(component, event, helper) {
        //Retrieve the subject and question that was submitted by the user
        var sub = component.get("v.subject");
        var quest = component.get("v.question");
        
        //Subject is null
        if(sub == null){
            alert("Please enter in value in subject");
        //Question is null
        } else if(quest == null) {
            alert("Please enter in values in body");
        //Save to Database
        } else{
            helper.saveQuestionHelper(component, sub, quest);
        } 
    }
             
            
})