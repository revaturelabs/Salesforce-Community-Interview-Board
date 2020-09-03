({
    doinit : function(component, event, helper) {
        var pickListStackValues;
        var outputList = [];
        var action = component.get("c.getTypePicklistValues");
        
        helper.getProfilePermStatus(component);
        helper.getMeetingStatus(component);
        helper.getTimeSlotStatus(component);
        helper.getAllTimeSlots(component);
        helper.getPendingApprovals(component);
        
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                let stackTypePicklist = response.getReturnValue();
                component.set("v.AllStacks", stackTypePicklist);
                console.log(stackTypePicklist);
            } else {
                console.log("Failed to get stack values in init.");
            }
        })
        
        
        $A.enqueueAction(action);
    },
    
    // Gets all time slots that have been created and are associated with a stack
    
    filterTimeSlots : function(component, event, helper) {
        
        var selectedStack = component.find("stack id").get("v.value");
        
        component.set("v.ActiveStack", selectedStack);
        
        var filteredTimeSlots = component.get("c.getFilteredTimeSlots");
        
        filteredTimeSlots.setParams({  filter :  selectedStack});
        
        console.log(filteredTimeSlots);
        
        filteredTimeSlots.setCallback(this, function(response){
            if(response.getState() === "SUCCESS") {
                component.set("v.AllTimeSlots", response.getReturnValue());
                console.log('All filtered time slots available: ' + response.getReturnValue());
            }
        });
        $A.enqueueAction(filteredTimeSlots);
    },
    
    setNeedsApproval: function(component, event, helper) {
        
        var selectedTimeSlot = component.find("slot id").get("v.value");
        
        console.log("This is the selected time slot: " + selectedTimeSlot);
        
        component.set("v.ActiveTimeSlot", selectedTimeSlot);
        
        if(confirm("Are you sure you want to select this time slot. This cannot be undone.")){
            
            var timeSlotsNeedingApproval = component.get("c.setNeedsApprovalTimeSlots");
            
            
            timeSlotsNeedingApproval.setParams({  filter :  selectedTimeSlot});
            
            console.log(timeSlotsNeedingApproval);
            
            timeSlotsNeedingApproval.setCallback(this, function(response){
                if(response.getState() === "SUCCESS") {
                    component.set("v.TimeSlotsAwaitingApproval", response.getReturnValue());
                    console.log('All  time slots awaiting approval: ' + response.getReturnValue());
                }
            });
            $A.enqueueAction(timeSlotsNeedingApproval);
            if(confirm("Your time slot has been selected. Check back to see when it is approved.")){
                //window.location.reload();
            }
            else{
                alert("Your time slot was not selected.");
            }
        }
    },
    
    setApprovalMeeting: function(component, event, helper) {
        
        var selectedApproval = component.find("approval id").get("v.value");
        
        component.set("v.ActiveApproval", selectedApproval);
        
    },
    
    openModel: function(component, event, helper) {
        // for Display Model,set the "isOpen" attribute to "true"
        // 
        
        var target = event.getSource();
        var buttonId = target.getLocalId(); 
        
        var activeApproval;
        
        if(buttonId == 'CreateMeetingButton'){
            
            activeApproval = component.get('v.ActiveTimeSlotApproval');
            component.set()
        }
        
        console.log('The target button id: ' + buttonId);
        
        component.set('v.TargetButtonId', buttonId);
        
        component.set("v.isOpen", true);
    },
    
    closeModel: function(component, event, helper) {
        // for Hide/Close Model,set the "isOpen" attribute to "Fasle"  
        component.set("v.isOpen", false);
    },
})