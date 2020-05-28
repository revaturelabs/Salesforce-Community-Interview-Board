//Interview Question Object Controller
//Responds to Aura Component- QuestionCreation

public class QuestionCreationController {

    //Save a record that a user has created from corresponding QuestionCreation.cmp
    @AuraEnabled
    public static void saveQuestion(String subject, String question){
        try{
             Interview_Question__c iq = new Interview_Question__c(Body__c = question, Subject__c = subject);
             insert iq;
        }catch(Exception e){
             System.debug(e.getMessage());
        }
    }
}