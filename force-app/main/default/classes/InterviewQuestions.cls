public class InterviewQuestions {
    //grabbing the meetings and the questions for our picklist
    @AuraEnabled
    public static List<List<sObject>> loadQuestionMap()
    {
        List<List<sObject>> objs = new List<List<sObject>>();

        objs.add([SELECT Id, Name FROM Meeting__c]);
        objs.add([SELECT Id,body__c,type__c, (SELECT Meeting_md__c FROM Interview_Questions__r)
                  FROM Question__c ORDER BY CreatedDate DESC]);
       
        //objs.add([SELECT Id, Question__r.body__c, Question__r.type__c, Meeting_md__c FROM Interview_Question__c ORDER BY CreatedDate DESC]);
        return objs;
    }
}