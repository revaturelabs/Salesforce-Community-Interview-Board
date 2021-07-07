({
    init : function(component, event, helper) {
        helper.fetchmeetingsHelper(component, event, helper);
        console.log('Meetings fetched')
    },

    openModel: function(component, event, helper) {
       // Set isModalOpen attribute to true
       component.set("v.isModalOpen", true);
    },
   
    closeModel: function(component, event, helper) {
       // Set isModalOpen attribute to false  
       component.set("v.isModalOpen", false);
    },
   
    submitDetails: function(component, event, helper) {
       // Set isModalOpen attribute to false
       console.log("Before attach questions")
       helper.attachQuestions(component, event, helper);
       console.log("After attach questions")
       //Add your code to call apex method or do some processing
       component.set("v.isModalOpen", false);
    },
 })