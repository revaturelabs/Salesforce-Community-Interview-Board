//Test QuestionCreation methods
@isTest
public class QuestionCreationTest {
   


   //test method "saveQuestion" which inserts a new Interview_Question__c record
    @isTest
    public static void testMethod1(){
        //These fields are no longer on the Interview_Question__c object
        //test the "try", when no exceptions occur 
        //QuestionCreationController.saveQuestion('subject101', '101', '');
        //Interview_Question__c tester = [Select Body__c, Subject__c From Interview_Question__c where Subject__c ='Subject101' LIMIT 1];
        //System.assertEquals('101', tester.Body__c);
    }
}