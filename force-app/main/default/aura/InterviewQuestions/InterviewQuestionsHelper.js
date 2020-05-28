({
    createMap : function(component, questions)
    {
        var sMap = component.get("v.subjectMap");
        for(var i = 0; i < questions.length; i++)
        {
            if(sMap[questions[i].Meeting__c] == null)
                sMap[questions[i].Meeting__c] = new Map();
            var qMap = sMap[questions[i].Meeting__c];
            console.log('this');
            if(qMap[questions[i].Subject__c] == null)
                qMap[questions[i].Subject__c] = [];
            console.log('that');
            qMap[questions[i].Subject__c].push(questions[i]);
            console.log(sMap[questions[i].Meeting__c][questions[i].Subject__c].get(0));
            sMap[questions[i].Meeting__c] = qMap;
            console.log('there');
        }

        component.set("v.subjectMap", sMap);
    }
})

/*
    Map<Id, Map<String, List<Interview_Question__c>>> questionMap = 
        new Map<Id, Map<String, List<Interview_Question__c>>>();

    for(Meeting__c meeting : [Select Id,(Select Id,Body__c,Subject__c from Interview_Questions__r) from Meeting__c])
    {
        if(questionMap.get(meeting.Id) == null)
            questionMap.put(meeting.Id, new Map<String, List<Interview_Question__c>>());

        for(Interview_Question__c question : meeting.Interview_Questions__r)
        {
            if(questionMap.get(meeting.Id).get(question.Subject__c) == null)
                questionMap.get(meeting.Id).put(question.Subject__c, new List<Interview_Question__c>());

            questionMap.get(meeting.Id).get(question.Subject__c).add(question);
        }

    }
*/