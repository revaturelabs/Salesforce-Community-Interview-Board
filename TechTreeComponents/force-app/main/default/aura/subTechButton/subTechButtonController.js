({
    sendCur : function(component, event, helper) {
        var curEve = component.getEvent("getCur");
        curEve.setParams({"cur":component.get("v.sTech.Name")});
        curEve.fire();
    }
})
