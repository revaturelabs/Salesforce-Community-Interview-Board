//Interview Question Object Controller
//Responds to Aura Component- QuestionCreation

public with sharing class QuestionCreationController {
    //Get all account records with the batch recordtype id
    @AuraEnabled
    public static List<Meeting__c> loadAllMeetings(){
        return [SELECT Name, Id FROM Meeting__c];  
    }
    //Save a record that a user has created from corresponding QuestionCreation.cmp
    @AuraEnabled
    public static void saveQuestion(String question, String meeting, String type, String stack){
        try{
            System.debug('id1 => ' + meeting);
            //evilValue is the value when None is selected. Thus, we want a null Meeting attached to the Interview Question record.
            if(meeting == 'evilValue') {
                meeting = null;
            }
            Question__c q = new Question__c(Body__c = question, Name=question,Type__c=type,Stack__c=stack);
            insert q;
            Interview_Question__c iq = new Interview_Question__c(Meeting_md__c = meeting, Question__c=q.Id);
            insert iq;
        }catch(Exception e) {
             System.debug(e.getMessage());
        }
    }
    //get the type picklist sorted by stack
    @AuraEnabled
    public static Map<String,List<String>> getTypePicklistValues() {
        return Utilities.getTypePicklistValues();
    }
}