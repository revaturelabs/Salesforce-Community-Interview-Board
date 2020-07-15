({
    init : function(component, event, helper) {
        helper.fetchMeetingsHelper(component, event, helper);
    },
    
    getquestions : function(component, event, helper){
        helper.getquestionsHelper(component, event, helper);
    },

    addQuestionScreen : function(component, event, helper) {
        component.set('v.addQuestionPopup', true);
    },

    questionSubmitted : function(component, event, helper) {
        component.set('v.addQuestionPopup', false);
    }
})