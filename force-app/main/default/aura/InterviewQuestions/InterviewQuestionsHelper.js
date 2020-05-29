({
    createMap : function(component, questions)
    {
        //take the list of questions (result1), put it in a map
        //Meeting ID is the key, question sObject is the value
        var qMap = component.get("v.questionMap");
        for(var i = 0; i < questions.length; i++)
        {
            if(qMap[questions[i].Meeting__c] == null)
                qMap[questions[i].Meeting__c] = [];
            qMap[questions[i].Meeting__c].push(questions[i]);
        }
        //set the qMap to questionMap on the component
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
        var qSub = [];
        var page = component.get("v.page") - 1;
        var perPage = component.get("v.perPage");

        for(var i = 0; i < perPage && i + page * perPage < questions.length; i++)
        {
            qSub.push(questions[i + page * perPage]);
        }

        component.set("v.qSub", qSub);
    },

    //if you change the meeting you pick, it should go back to page 1
    resetPage : function(component)
    {
        component.set("v.page", 1);
        this.setPage(component);
    }
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