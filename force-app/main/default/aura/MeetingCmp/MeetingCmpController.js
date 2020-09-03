({
    // Makes callout to apex controller 'MeetingController' to get boolean return value
	doInit : function(component, event, helper) {
        helper.getMeetingId(component, event);
        helper.getActiveStack(component, event);
        let confFalse = false;
        component.set("v.confirmIsTrue", confFalse);
		let getPerm = component.get("c.getProfilePerm");  
        getPerm.setCallback(this, function(response){
            if(response.getState() === "SUCCESS") {
            component.set("v.AdminPerm", response.getReturnValue());
            }
            });
        
       $A.enqueueAction(getPerm); 
	},
    
    // action to change update recordEditForm to a recordViewForm after the user clicks the confirm button
    confirmTrue : function(component){
        let confTrue = true;
        component.set("v.confirmIsTrue", confTrue);
        
    },
    
    // action to send start time and end time to meetingController to create new timeslots. 
    confirmTimeslot : function(component, event, helper){
        let confirmStart = component.find("StartAvail").get("v.value");
        let confirmEnd = component.find("EndAvail").get("v.value");
        let stack = component.get("v.ActiveStack");        
        console.log(stack);
        
        let setTime = component.get("c.createTimeslots");
        setTime.setParams({
            "startTime" : confirmStart,
            "endTime" : confirmEnd,
            "tStack" : stack
        });
        setTime.setCallback(this, function(response){
             if(response.getState() === "SUCCESS") {
                let numTimeslots = response.getReturnValue();
				alert('You successfully created ' + numTimeslots + ' timeslots!');
            }
        });
           $A.enqueueAction(setTime); 
        
        
    },
    
    createGoogleMeets : function(component, event, helper){
        let createMeeting = component.get("c.createEvent");
        let sumMeet = component.find("Name").get("v.value");
        let startDateMeet = component.find("StartAvailability").get("v.value");
        let endDateMeet = component.find("EndAvailability").get("v.value");	
        console.log(sumMeet);
        console.log(startDateMeet);
        console.log(endDateMeet);
        createMeeting.setParams({
            "sum" : sumMeet,
            "startDate" : startDateMeet,
            "endDate" : endDateMeet,
        });
        createMeeting.setCallback(this, function(response){
            if(response.getState() === "SUCCESS"){
				console.log("success");                
            }
        });
        $A.enqueueAction(createMeeting);
    },
    
    setStack : function(component, event, helper) {
    	let chosenStack = component.find("stack").get("v.value");
        component.set("v.ActiveStack", chosenStack);
        console.log(chosenStack);
    }, 
})