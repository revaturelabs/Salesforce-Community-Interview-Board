({
    
    // Checks if any ed meetings have been created and displays update meeting button if meetings exist.
   
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
    
       // Checks if any meetings have been created and displays update meeting button if meetings exist.
   
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
    
    
    
    // Get details from existing meetings that can be updated.
   
    getMeetingDetails : function(component, item, callback) {
        
        var meetingDetails = component.get("c.getMeetings");
        
        meetingDetails.setCallback(this, function(response){
            
            if(response.getState() === "SUCCESS") {
                
                var meetingDetailsResponse = response.getReturnValue();
                
                component.set('v.MeetingDetailsMap', meetingDetailsResponse);
                
                console.log('Meeting details response: ' + meetingDetailsResponse);
            }
        });
        $A.enqueueAction(meetingDetails);
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