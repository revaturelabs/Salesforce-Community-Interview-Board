({
    createMap : function(component, questions)
    {
        var qMap = component.get("v.questionMap");
        for(var i = 0; i < questions.length; i++)
        {
            if(qMap[questions[i].Meeting__c] == null)
                qMap[questions[i].Meeting__c] = [];
            qMap[questions[i].Meeting__c].push(questions[i]);
        }

        component.set("v.questionMap", qMap);
        //near, far, wherever you are
    }
})