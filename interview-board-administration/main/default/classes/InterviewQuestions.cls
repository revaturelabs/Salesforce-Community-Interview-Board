public class InterviewQuestions {
    //grabbing the meetings and the questions for our picklist
    @AuraEnabled
    public static List<List<sObject>> loadQuestionMap()
    {
        List<List<sObject>> objs = new List<List<sObject>>();
        Id recordTypeId = Schema.SObjectType.Meeting__c.getRecordTypeInfosByName().get('Mock Interview').getRecordTypeId();

        objs.add([SELECT Id, Name FROM Meeting__c WHERE RecordTypeId !=: recordTypeId]);
        objs.add([SELECT Id,Question__r.body__c,Question__r.type__c,Meeting_md__c FROM Interview_Question__c
                 ORDER BY CreatedDate DESC]);
        return objs;
    }
}