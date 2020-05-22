({
    ascMap : function(component) {
        var asc = component.get("v.associates");
        var ascMap = component.get("v.ascbatchmap");
        for(var i = 0; i < asc.length; i++)
        {
            if(ascMap[asc[i].AccountId] == null)
                ascMap[asc[i].AccountId] = [];
            ascMap[asc[i].AccountId].push(asc[i]);
        }
        component.set("v.ascbatchmap", ascMap);
    }
})