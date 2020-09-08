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
                	window.open('/one/one.app?#/sObject/' + eventId + '/view', '_blank');
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
                        }
                    }
                }
            });
        },

    tranformToFullCalendarFormat : function(component,events) {
        var eventArr = [];
        for(var i = 0;i < events.length;i++){
            eventArr.push({
                'id':events[i].Id,
                'start':events[i].StartDateTime__c,
                'end':events[i].EndDateTime__c,
                'title':events[i].Name
            });
        }
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