public class QuizQuestionService extends QuizAbstractDataService {
    public List<Quiz_Question__c> getQuestions(String stack) {
        return [SELECT Id, Label__c, Stack__c FROM Quiz_Question__c WHERE Stack__c =: stack];
    }
}