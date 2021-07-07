({
    init : function(component, event, helper) {
        helper.fetchMeetingsHelper(component, event, helper);
    },
    /* Unused functionality
    getquestions : function(component, event, helper){
        helper.getquestionsHelper(component, event, helper);
    },
    */
    addQuestionScreen : function(component, event, helper) {
        component.set('v.addQuestionPopup', true);
    },

    questionSubmitted : function(component, event, helper) {
        console.log('Interview question submitted successfully');
        component.set('v.addQuestionPopup', false);
    }
})