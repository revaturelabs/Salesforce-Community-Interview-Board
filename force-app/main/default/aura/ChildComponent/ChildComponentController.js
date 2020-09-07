({
    //this function is assigning value to attributes in child component that will display subtech,primarytech and stack
	doInit : function(component, event, helper) {
        var key = component.get("v.key");
        var map = component.get("v.map");
        component.set("v.value" , map[key]);
    },
})