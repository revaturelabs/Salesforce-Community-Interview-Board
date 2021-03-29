//Test QuestionCreation methods
@isTest
public class QuestionCreationTest {
   


   //test method "saveQuestion" which inserts a new Interview_Question__c record
    @isTest
    public static void testMethod1(){
        //String question, String meeting, String type, String stack, Boolean associate, String setting
        QuestionCreationController.saveQuestion('Test', 'evilValue', 'Soft Skills', 'Salesforce', false, 'Interview');
    }
}