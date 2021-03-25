//Interview Question Object Controller
//Responds to Aura Component- QuestionCreation

public with sharing class QuestionCreationController {
    //Get all existing Meeting records
    @AuraEnabled
    public static List<Meeting__c> loadAllMeetings(){
        return [SELECT Name, Id FROM Meeting__c];  
    }
    
    //Get the user info for the option to add the question to a meeting
    @AuraEnabled
    public static Boolean isAssociate() {
        Profile currentProfile = [SELECT Id, Name FROM Profile WHERE Id=:UserInfo.getProfileId()];
        if(currentProfile.Name == 'Associate') {
            return true;
        } else {
        	return false;
        }
    }
    
    //Save a record that a user has created from corresponding QuestionCreation.cmp
    @AuraEnabled
    public static void saveQuestion(String question, String meeting, String type, String stack, Boolean associate, String setting){
        //Set the visibility field for the Question
        String visibility;
        if(associate){
            visibility = 'Associate';
        } else {
            visibility = 'Admin';
        }
        try{
            System.debug('id1 => ' + meeting);
            //evilValue is the value when None is selected. Thus, we want a null Meeting attached to the Interview Question record.
            if(meeting == 'evilValue') {
                meeting = null;
            }
            Question__c q = new Question__c(Body__c = question,Type__c=type,Stack__c=stack, Visibility__c=visibility);
            insert q;
            //Interview_Question__c iq = new Interview_Question__c(Meeting_md__c = meeting, Question__c=q.Id);
            //insert iq;
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