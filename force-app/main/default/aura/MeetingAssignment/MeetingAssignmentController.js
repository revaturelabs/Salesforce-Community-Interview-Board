({
    /*
    handleClick- activated from search button in view, search engine for handling meeting propagation
    based on drop down entries
    parameters:
    component-- component markup
    helper-- MeetingAssignmentHelper.js
     */
    handleClick : function(component, event, helper) {
        
        //gather view attributes and assign to reference variables
      var batchItem = component.find("selectlist").get("v.value");
       var nameItem = component.find("assoclist").get("v.value");
        var searchSF = component.get("c.getMeetings");//apex getMeeting
		 var reset = component.set("v.body", ''); 
        searchSF.setParams({participant:nameItem,
                            batch:batchItem});
        searchSF.setCallback(this, function(response)
        {
            var state = response.getState();
            if (state == "SUCCESS")
            {
                //if successful callback, get return list, iterate and pass to helper
                console.log('STATE SUCCESSFUL');
                var returns = response.getReturnValue();
                console.log(returns);
                 
                for (let i=0; i<returns.length; i++)
                {               
   
                    var value = returns[i];
                    console.log(value);
                    helper.build(component, value);
                }
            }
        });
        $A.enqueueAction(searchSF);
    },
    /*
    doInit- initializes batch dropdown list
    parameters:
    component-- component markup
     */
    doInit : function(component, event, helper)
    {
        var searchBatches = component.get("c.getBatchNames")//apex getBatchNames
        searchBatches.setCallback(this, function(response)
        {
            var state = response.getState();
            if (state == "SUCCESS")
            {
                //if successful callback, get return list and assign to batch selection array
                let batchNames = response.getReturnValue();
                let setBatch = component.set("v.batchSelect", batchNames);
            }
        })
        $A.enqueueAction(searchBatches);
       var setAssocs = component.find("selectlist").get("v.value");
       
    },
    /*
    initAssocs- sets a list in associate dropdown based on batch entry, triggered when batch is set
    parameters:
    component-- component markup
    */
    initAssocs : function(component, event, helper)
    {
        var searchAssociates = component.get("c.getAssociates");// apex getAssociates
        //get batch dropdown selection and set parameter for callback function
        var setName = component.find("selectlist").get("v.value");
        
        
        searchAssociates.setParams({batchName:setName});
        searchAssociates.setCallback(this, function(response){
            var state = response.getState();
            if (state == "SUCCESS")
            {
                //if successful callback, get return list values and assign to associate selection array
                var associates = response.getReturnValue();
                component.set("v.assocList", associates);
            }
        } )
        $A.enqueueAction(searchAssociates);
    }
})