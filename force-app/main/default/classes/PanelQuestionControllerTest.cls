//Test class for PanelQuestionController
@isTest
public class PanelQuestionControllerTest {
	@isTest
    static void saveQuestionTest(){
        //set up dummy question data
        String question, type, stack;
        Boolean associate;
        Question__c actObj;
        
        //Associate
        question = 'What is Apex?';
        type = 'Apex';
        stack = 'Salesforce';
        associate = true;
        
        //Call method
		PanelQuestionController.saveQuestion(question, type, stack, associate);
        
        //Check if successfully added
        try{
            actObj = [SELECT id, Body__c, Type__c, Stack__c FROM Question__c WHERE Body__c = :question 
                      AND Type__c  = :type AND Stack__c = :stack AND Visibility__c = 'Associate' LIMIT 1];
        }
        catch (Exception e){
            System.debug(e.getMessage());
        }
        
        System.assert( (actObj != null) );
    }
}