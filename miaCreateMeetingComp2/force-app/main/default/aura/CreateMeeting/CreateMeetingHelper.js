({
    ascMap : function(component) {
        var asc = component.get("v.associates");
        var ascMap = component.get("v.ascbatchmap");
        for(var a in asc)
        {
            ascMap[a.AccountId].push(a);
        }
    }
})
