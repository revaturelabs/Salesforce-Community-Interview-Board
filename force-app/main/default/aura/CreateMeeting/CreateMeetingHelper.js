({
    ascMap : function(component) {

        // getting the list of all associates from the component
        var asc = component.get("v.associates");

        // getting the associate-batch map variable from the component
        var ascMap = component.get("v.ascbatchmap");

        // looping through all associates and assigning them to a list in
        // the map based on their batch (account) Id
        for(var i = 0; i < asc.length; i++)
        {
            // looking if there is already a list for the account Id
            // If it doesn't exist, create one for that Id
            if(ascMap[asc[i].AccountId] == null)
                ascMap[asc[i].AccountId] = [];

            // adding the associate to the list for the account
            ascMap[asc[i].AccountId].push(asc[i]);
        }

        // setting the map back in the component
        component.set("v.ascbatchmap", ascMap);
    }
})