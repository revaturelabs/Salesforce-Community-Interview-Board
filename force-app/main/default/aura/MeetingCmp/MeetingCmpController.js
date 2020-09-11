({
    // Makes callout to apex controller 'MeetingController' to get boolean return value
    doInit : function(component, event, helper) {
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
        let confirmIntName = component.find("intName").get("v.value");
        let stack = component.get("v.ActiveStack");        
        console.log(stack);
        
        let setTime = component.get("c.createTimeslots");
        setTime.setParams({
            "startTime" : confirmStart,
            "endTime" : confirmEnd,
            "tStack" : stack,
            "intName" : confirmIntName
        });
        setTime.setCallback(this, function(response){
            if(response.getState() === "SUCCESS") {
                let numTimeslots = response.getReturnValue();
                if(numTimeslots <= 0) {
                    alert('No time slots created.');
                }
                else {
                    alert('You successfully created ' + numTimeslots + ' time slots!');
                }
                window.location.reload(false);
            }
        });
        $A.enqueueAction(setTime); 
        
        
    },
    
    createGoogleMeets : function(component, event, helper){
        let createMeeting = component.get("c.createEvent");
        let meetId = component.get("v.meetingId");
        
        let sumMeet = component.find("Name");//.get("v.value");
        sumMeet = Array.isArray(sumMeet) ? sumMeet[0].get("v.value") : sumMeet.get("v.value");
        
        let interviewerName = component.find("InterviewerName");//.get("v.value");
        interviewerName = Array.isArray(interviewerName) ? interviewerName[0].get("v.value") : interviewerName.get("v.value");
        
        let startDateMeet = component.find("StartAvailability");//.get("v.value");
        startDateMeet = Array.isArray(startDateMeet) ? startDateMeet[0].get("v.value") : startDateMeet.get("v.value");
        
        let endDateMeet = component.find("EndAvailability");//.get("v.value");
        endDateMeet = Array.isArray(endDateMeet) ? endDateMeet[0].get("v.value") : endDateMeet.get("v.value");
        
        console.log(meetId);
        console.log(sumMeet);
        console.log(startDateMeet);
        console.log(endDateMeet);
        console.log(interviewerName);
        createMeeting.setParams({
            "meetId" : meetId,
            "sum" : sumMeet,
            "startDate" : startDateMeet,
            "endDate" : endDateMeet,
            "intName" : interviewerName,
        });
        createMeeting.setCallback(this, function(response){
            if(response.getState() === "SUCCESS"){
                console.log("success");   
                alert("Meeting successfully updated!");
                window.location.reload(false);
            }
        });
        $A.enqueueAction(createMeeting);
    },
    
    setStack : function(component, event, helper) {
        let chosenStack = component.find("stack").get("v.value");
        component.set("v.ActiveStack", chosenStack);
        console.log(chosenStack);
    }, 
    
    
    goToMeeting : function(component, event, helper) {
        let goMeeting = component.get("c.getEvent");
        let meetId = component.get("v.meetingId");
        //console.log(meetId);
        goMeeting.setParams({
            "meetingId" : meetId
        });
        goMeeting.setCallback(this, function(response){
            let meetsLink = response.getReturnValue();
            console.log(meetsLink);
            window.open(meetsLink);
        })
        $A.enqueueAction(goMeeting);
    }
})