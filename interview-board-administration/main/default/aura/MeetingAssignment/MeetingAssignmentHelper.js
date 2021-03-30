({
    /*
    build- create a component of type MeetingTile
    parameters:
    cmp- top level component accessed by js controller
    meeting- individual meeting object identified in js controller from the apex return list
     */
    build : function(cmp, meeting) {
        //set reference variable for meeting object
        var setMeeting = meeting;
      //create component and set the reference variable on Meeting attribute
      console.log("creating a component");
            $A.createComponent("c:MeetingTiles", {
                "Meeting":setMeeting,
 
            }, function(newComponent, state, error)
            {
                //if component is created, push to the top level component body
                    if(state == "SUCCESS")
                    {
                       var body= cmp.get("v.body");
                       body.push(newComponent);
                       cmp.set("v.body",body);
                       
                    }
            } );
    }
})