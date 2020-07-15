({
    createMap : function(component, meetings, questions)
    {
        //take the list of questions (result1), put it in a map
        //Meeting ID is the key, question sObject is the value
        var qMap = component.get("v.questionMap");
        for(var i = 0; i < meetings.length; i++)
        {
            qMap[meetings[i].Id] = [];
        }
        var temp = [];
        for (let i=0; i<questions.length;i++) {
            let id = questions[i].Interview_Questions__r[0];
            let question = questions[i];
            question.Interview_Questions__r=id;
            temp.push(question);
        }
        console.log(temp);

        for(var i = 0; i < temp.length; i++)
        {
            if(qMap[temp[i].Interview_Questions__r.Meeting_md__c] == null)
                qMap[temp[i].Interview_Questions__r.Meeting_md__c] = [];
            qMap[temp[i].Interview_Questions__r.Meeting_md__c].push(temp[i]);
        }
        //set the qMap to questionMap on the component
        console.log(qMap);
        component.set("v.questionMap", qMap);
        
    },

    //Handles disabling the "next" and "previous" buttons
    //if we reach the beginning/end of pagination
    disable : function(component)
    {
        var page = component.get("v.page");
        var perPage = component.get("v.perPage");
        var qCnt = component.get("v.questions").length;

        if(page < 1)
        {
            page = 1;
            component.set("v.page", 1);
        }

        component.set("v.disPrev", (page == 1));
        component.set("v.disNext", (page * perPage >= qCnt));
    },

    //This breaks up the amount of questions per page
    setPage : function(component)
    {
        var questions = component.get("v.questions");
        var qType = [];
        var page = component.get("v.page") - 1;
        var perPage = component.get("v.perPage");

        for(var i = 0; i < perPage && i + page * perPage < questions.length; i++)
        {
            qType.push(questions[i + page * perPage]);
        }

        component.set("v.qType", qType);
    },

    //if you change the meeting you pick, it should go back to page 1
    resetPage : function(component)
    {
        component.set("v.page", 1);
        this.setPage(component);
    },
})

/* if the createMap code was in Apex, this is what it'd be:
Map<Id, List<sObject>> qMap = new Map<Id, List<sObject>>();
for(Interview_Question__c question : questions)
{
    if(qMap.get(question.Meeting__c) == null)
        qMap.put(question.Meeting__c, new List<sObject>());
    qMap.get(question.Meeting__c).add(question);
}
*/