({
    
    // Checks if any meetings have been created and displays update meeting button if meetings exist.
   
    getMeetingStatus : function(component, item, callback) {
        
        var meetingStatus = component.get("c.hasScheduledMeetings");
        
        
        meetingStatus.setCallback(this, function(response){
            
            if(response.getState() === "SUCCESS") {
                
                var meetingStatusResponse = response.getReturnValue();
                component.set("v.UpdateMeeting", response.getReturnValue());
                console.log('Status for scheduled meetings: ' + meetingStatusResponse);
             
            }
        });
        $A.enqueueAction(meetingStatus);
    },
    
       // Checks if any meetings are awaiting approval and displays update meeting button if meetings exist.
   
    getTimeSlotStatus : function(component, item, callback) {
        
        var timeSlotStatus = component.get("c.hasUnScheduledTimeSlots");
        
        
        timeSlotStatus.setCallback(this, function(response){
            
            if(response.getState() === "SUCCESS") {
                
                var timeSlotStatusResponse = response.getReturnValue();
                component.set("v.CreateMeeting", response.getReturnValue());
                console.log('Status of unscheduled meetings (time slots): ' + timeSlotStatusResponse);
             
            }
        });
        $A.enqueueAction(timeSlotStatus);
    },
    
    
    // Get Id from existing meetings that can be updated.
   
    getMeetingApprovalId : function(component, item, callback) {
        
        var activeApproval = component.get('v.ActiveApproval');
        
        var approvalId = component.get("c.getApprovalId");
        
        console.log(activeApproval);
        
        approvalId.setParams({  filter :  activeApproval});
        approvalId.setCallback(this, function(response){
            
            if(response.getState() === "SUCCESS") {
                
                var approvalIdResponse = response.getReturnValue();
                
                component.set('v.MeetingId', approvalIdResponse);
                
                console.log('Approval Meeting Id response: ' + approvalIdResponse);
            }
        });
        $A.enqueueAction(approvalId);
    },
    
    // Get Id from existing meetings that should be updated.
   
    getMeetingUpdateId : function(component, item, callback) {
        
        
        var activeEvent = component.get('v.ActiveEvent');
        
        var updateId = component.get("c.getId");
        
        console.log(activeEvent);
        
        updateId.setParams({  filter :  activeEvent});
        
        updateId.setCallback(this, function(response){
            
            if(response.getState() === "SUCCESS") {
                
                var updateIdResponse = response.getReturnValue();
                
                component.set('v.MeetingId', updateIdResponse);
                
                console.log('Update Meeting Id response: ' + updateIdResponse);
            }
        });
        $A.enqueueAction(updateId);
    },
    
     // Get Id from existing meetings that should be viewed.
   
    getMeetingUpdateId : function(component, item, callback) {
        
        
        var activeEvent = component.get('v.ActiveMeeting');
        
        var viewId = component.get("c.getId");
        
        console.log(activeEvent);
        
        viewId.setParams({  filter :  activeEvent});
        
        viewId.setCallback(this, function(response){
            
            if(response.getState() === "SUCCESS") {
                
                var viewIdResponse = response.getReturnValue();
                
                component.set('v.MeetingId', viewIdResponse);
                
                console.log('View Meeting Id response: ' + viewIdResponse);
            }
        });
        $A.enqueueAction(viewId);
    },
    
    
    // Gets all time slots that have been created and adds them to the view
   
    getAllTimeSlots : function(component, item, callback) {
        
        var meetingTimeSlots = component.get("c.getTimeSlots");
        
        console.log(meetingTimeSlots);
        
        meetingTimeSlots.setCallback(this, function(response){
            if(response.getState() === "SUCCESS") {
                component.set("v.AllTimeSlots", response.getReturnValue());
                console.log('All time slots available: ' + response.getReturnValue());
            }
        });
        $A.enqueueAction(meetingTimeSlots);
    },
    
    // Gets all meetings that have been created and adds them to the view
   
    getAllMeetings : function(component, item, callback) {
        
        var meetings = component.get("c.getMeetings");
        
        meetings.setCallback(this, function(response){
            if(response.getState() === "SUCCESS") {
                component.set("v.AllMeetings", response.getReturnValue());
                console.log('All meetings available: ' + response.getReturnValue());
            }
        });
        $A.enqueueAction(meetings);
    },
    
    getPendingApprovals : function(component, item, callback) {
        
        var approvalTimeSlots = component.get("c.getNeedsApprovalTimeSlots");
        
        console.log(approvalTimeSlots);
        
        approvalTimeSlots.setCallback(this, function(response){
            if(response.getState() === "SUCCESS") {
                component.set("v.TimeSlotsAwaitingApproval", response.getReturnValue());
                console.log('All  time slots awaiting approval: ' + response.getReturnValue());
            }
        });
        $A.enqueueAction(approvalTimeSlots);
    },
    
    // Profile status used to determine what elements to display based on Sys Admin permissions
    
    getProfilePermStatus : function(component, item, callback) {
        
        let getPerm = component.get("c.getProfilePerm");
        
        getPerm.setCallback(this, function(response){
            if(response.getState() === "SUCCESS") {
                component.set("v.AdminPerm", response.getReturnValue());
                console.log('Admin profile permission status: ' + response.getReturnValue());
            }
        });
        
        $A.enqueueAction(getPerm); 
    }
})