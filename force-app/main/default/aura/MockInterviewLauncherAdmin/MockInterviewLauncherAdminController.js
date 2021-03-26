({
    init : function(component, event, helper) {
        helper.fetchmeetingsHelper(component, event, helper);
    },

    launchInterview : function(component, event, helper) {
        helper.launchInterviewHelper(component, event, helper);
    },

    nextQuestion : function(component, event, helper) {
        helper.nextQuestionHelper(component, event, helper);
    },

    endInterview : function(component, event, helper) {
        helper.endInterviewHelper(component, event, helper);
    }

})