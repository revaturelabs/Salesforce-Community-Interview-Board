public class InterviewQuestions {
    
    @AuraEnabled
    public static List<List<sObject>> loadQuestionMap()
    {
        List<List<sObject>> objs = new List<List<sObject>>();

        objs.add([SELECT Id, Name FROM Meeting__c]);
        objs.add([SELECT Id, Subject__c, Body__c, Meeting__c FROM Interview_Question__c]);
       
        return objs;
    }
    
    @AuraEnabled
    public static List<Meeting__c> getMeetings()
    {
        return [select Id, Name from Meeting__c];
    }

}