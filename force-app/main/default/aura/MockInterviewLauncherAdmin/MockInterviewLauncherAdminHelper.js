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

    launchInterviewHelper : function(component, event, helper) {
        var action = component.get("c.GetInterviewQuestions");
        action.setParams({"meetingid" : component.find("meetingSelect").get("v.value")});
        action.setCallback(this, function(response){
            var state = response.getState();
           if (state === "SUCCESS") {
               console.log('SUCCESS')
               component.set("v.questionList", response.getReturnValue())
               component.set("v.currentMeeting", component.find("meetingSelect").get("v.value"))
               var qList = component.get("v.questionList")
               component.set("v.currentQuestion", qList[0])
               component.set("v.launched", true)
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

    nextQuestionHelper : function(component, event, helper) {
            var action = component.get("c.UpdateResponseIQ")
            action.setParams({"q" : component.get("v.currentQuestion"), "response" : component.find("responseText").get("v.value"), "meet" : component.get("v.currentMeeting")});
            action.setCallback(this, function(response){
                var state = response.getState();
           if (state === "SUCCESS") {
               var qList = component.get("v.questionList")
                var index = component.get("v.currentQuestionIndex")
                index = index + 1
                component.set("v.currentQuestionIndex", index)
                component.set("v.currentQuestion", qList[index])
                component.find("responseText").set("v.value", "")
                if (component.get("v.currentQuestion") == undefined)
                    {
                        component.set("v.finished", true)
                    }
            }
        });
        $A.enqueueAction(action);
    },

    endInterviewHelper : function(component, event, helper) {
        component.set("v.currentQuestionIndex", 0)
        component.set("v.launched", false)
        component.set("v.finished", false)
    }
})