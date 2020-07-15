({
onmodalclosehelper : function(component, event) {
        var e = component.getEvent("FlowClose");
        console.log("Firing onmodalclose")
        e.setParams({"FlowClose" : true }); 
        e.fire(); 
    }
})