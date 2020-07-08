public class CreateMockInterviewController {
    public static List<Question__c> getQuestionList(Integer numQuestions){
        //TODO must filter by types. Need to add type field to Question Object
        List<Question__c> qList = [SELECT Subject__c,Body__c,Name FROM Question__c];
        List<Question__c> outputList = new List<Question__c>();
        Integer index;
        while(outputList.size()<numQuestions){
            index=Math.floor(Math.random() * qList.size()).intValue();
            outputList.add(qList[index]);
            qList.remove(index);
        }
        return outputList;
    }
    @AuraEnabled
    public static void createMockInterview(Integer numQuestions){
        List<Question__c> questionsToBeAdded = new List<Question__c>();
        questionsToBeAdded = CreateMockInterviewController.getQuestionList(numQuestions);
        Id recordTypeId = Schema.SObjectType.Meeting__c.getRecordTypeInfosByName().get('Mock Interview').getRecordTypeId();
        Meeting__c mockInterview = new Meeting__c(Name= 'Mock interview with '+numQuestions+' questions',
                                                    Meeting_Status__c='Mock',
                                                    RecordTypeId=recordTypeId);
        Database.SaveResult savedInterview = Database.insert(mockInterview);
        Id interviewId = savedInterview.getId();
        List<Interview_Question__c> interviewQuestions = new List<Interview_Question__c>();
        for (Question__c q : questionsToBeAdded) {
            Interview_Question__c addedQuestion = new Interview_Question__c(Body__c = q.Body__c,
                                                                            Name=q.Name,
                                                                            Meeting_md__c=interviewId,
                                                                            Meeting__c=interviewId,
                                                                            Question__c=q.Id,
                                                                            Subject__c=q.Subject__c);
            interviewQuestions.add(addedQuestion);
        }
        insert interviewQuestions;
    }
}