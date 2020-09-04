({
    afterScriptsLoaded: function(cmp,evt,helper){
        var events = cmp.get("v.events");
        console.log(events);
        if(!events.length)
        {
            helper.fetchEvents(cmp);
        }
    },
})