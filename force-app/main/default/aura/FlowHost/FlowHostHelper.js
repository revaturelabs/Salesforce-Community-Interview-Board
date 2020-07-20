({
onmodalclosehelper : function(component, event) {
    //handles sending the flow close event to the parent component.   
    var e = component.getEvent("FlowClose");
        console.log("Firing onmodalclose")
        e.setParams({"FlowClose" : true }); 
        e.fire(); 
    }
})