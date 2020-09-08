({
    loadDataToCalendar :function(component,data){      
            var ele = component.find('calendar').getElement();
            $(ele).fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,basicWeek,basicDay'
                },
                timezone: 'local',
                navLinks: true,
                editable: true,
                eventLimit: true,
                events:data,
                eventClick: function (calEvent, jsEvent, view) {
                	var eventId = calEvent.id;
                	window.open('https://08192020b-developer-edition.na123.force.com/s/meeting/' + eventId, "_blank");
                    return false;
            	},
                eventRender: function(event, element, view) {                   
                    var ntoday = new Date().getTime();
                    var eventEnd = moment( event.end ).valueOf();
                    var eventStart = moment( event.start ).valueOf();
                    if (!event.end){
                        if (eventStart < ntoday){
                            element.addClass("past-event");
                            element.children().addClass("past-event");
                        }
                    } else {
                        if (eventEnd < ntoday){
                            element.addClass("past-event");
                            element.children().addClass("past-event");
                        } else if(event.url == "not-scheduled") {
                            element.addClass("not-scheduled");
                            element.children().addClass("not-scheduled");
                        } else if(event.url == "awaiting-approval") {
                            element.addClass("awaiting-approval");
                            element.children().addClass("awaiting-approval");
                        } else if(event.url == "scheduled") {
                            element.addClass("scheduled");
                            element.children().addClass("scheduled");
                        }
                    }
                }
            });
        },

    tranformToFullCalendarFormat : function(component,events) {
        console.log(events);
        var eventArr = [];
        for(var i = 0;i < events.length;i++){
            var tempStatus = "";
            if(events[i].Meeting_Status__c == "Not Scheduled") {
                tempStatus = "not-scheduled";
            } else if(events[i].Meeting_Status__c == "Awaiting Approval") {
                tempStatus = "awaiting-approval";
            } else if(events[i].Meeting_Status__c == "Scheduled") {
                tempStatus = "scheduled";
            } else {
                tempStatus = "none";
            }
            console.log(tempStatus);
            	
            eventArr.push({
                'id':events[i].Id,
                'start':events[i].StartDateTime__c,
                'end':events[i].EndDateTime__c,
                'title':events[i].Name,
                'url':tempStatus,
            });
        }
        console.log(eventArr);
        return eventArr;
    },

    fetchEvents : function(component) {
        var action = component.get("c.getMeetings"); 
        var self = this;
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS"){
                var eventArr = self.tranformToFullCalendarFormat(component,response.getReturnValue());
                self.loadDataToCalendar(component,eventArr);
                component.set("v.events",eventArr);
            }
        });

        $A.enqueueAction(action); 
    }, 
    
})