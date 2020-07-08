public class CreateMockInterviewController {
    public static Set<Question__c> getQuestionList(Integer numQuestions){
        //TODO must filter by types. Need to add type field to Question Object
        List<Question__c> qList = [SELECT Subject__c,Body__c,Name FROM Question__c];
        Set<Question__c> outputList = new Set<Question__c>();
        Integer sizeofQPool = qList.size();
        while(outputList.size()<numQuestions){
            outputList.add(qList[ Math.floor(Math.random() * sizeofQPool).intValue()]);
        }
        return outputList;
    }
}
