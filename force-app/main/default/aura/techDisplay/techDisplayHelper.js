({
    prime : function(component) {
        console.log("here");
        let action = component.get("c.getTech");
        console.log("after");
        action.setCallback(this, function(response){
            let state = response.getState();
            console.log(response.getState());
            if(state === "SUCCESS"){
                component.set("v.primeTech", response.getReturnValue());
                console.log(response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },

    setSub : function(component, event) {
        let subTech = event.getParam("sub");
        component.set("v.subTech", subTech);
        component.set("v.clickedTwo", true);
        component.set("v.clicked", false);
    },

    setCont : function(component){
        try {
            var items = component.get("v.ChallengeItems");
            var newItems = [];
            for(let i = 0; i < items.length; i++){
                if(items[i].Completed__c==false){
                    newItems.push(items[i]);
                }
            }
            component.set("v.ChallengeDisplay", newItems);
        } catch(err) {
            component.set("v.ErrBool", true);
        }

    },
    /*setComp : function(component){
        try {
            var items = component.get("v.ChallengeItems");
            var newItems = [];
            for(let i = 0; i < items.length; i++){
                if(items[i].Completed__c==true){
                    newItems.push(items[i]);
                }
            }
            component.set("v.ChallengeDisplay", newItems);
        } catch (Err) {
            component.set("v.ErrBool", true);
        }

    }*/
})