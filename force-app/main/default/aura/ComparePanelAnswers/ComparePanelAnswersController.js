({
    handleCompareEvent : function(component, event, helper) {
        console.log("In handleCompareEvent");
        //let communityBestAnswer = component.get('v.communityBestAnswer');
        // let userAnswer = event.get("userAnswer");
        // let questionId = event.get("questionId");
        // console.log(userAnswer + " " + questionId);
        helper.handleCompareEventHelp(component, event, helper);
        component.set("v.compareClicked" , true);
    },

    fireCompareEvent : function(cmp, evt, help){
        console.log("In firecompareevent");
        let appEvent = $A.get("e.c:CompareAppEvent");
        appEvent.setParams({"questonId" : "v.id" , "userAnswer" : "v.userAnswer"});
        cmp.set("v.compareClicked", true);
        console.log(appEvent);
        let testBool = cmp.get("v.compareClicked");
        console.log(testBool);
        appEvent.fire();
    }
})