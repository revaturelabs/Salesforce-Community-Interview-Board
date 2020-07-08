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
}