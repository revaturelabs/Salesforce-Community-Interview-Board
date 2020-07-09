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
    public static void saveQuestion(String subject, String question, String meeting){
        try{
            System.debug('id1 => ' + meeting);
            //evilValue is the value when None is selected. Thus, we want a null Meeting attached to the Interview Question record.
            if(meeting == 'evilValue') {
                meeting = null;
            }
             Interview_Question__c iq = new Interview_Question__c(Body__c = question, Subject__c = subject, Meeting__c = meeting, Name=subject);
             insert iq;
        }catch(Exception e) {
             System.debug(e.getMessage());
        }
    }
}