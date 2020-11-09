@isTest
public class comparePanelAnswersTest {

    @TestSetup
    static void makeQuestionResponses(){

        Question__c question = new Question__c();

        Question_Response__c bestResponse = new Question_Response__c();
        Question_Response__c badResponse = new Question_Response__c();
        
        bestResponse.Name = 'QR-0000';
        bestResponse.Question__r.Id = question.Id;
        bestResponse.Total_Rating__c = 25;

        badResponse.Name = 'QR-0001';
        badResponse.Question__r.Id = question.Id;
        badResponse.Total_Rating__c = 15;

        insert question;
        insert bestResponse;
        insert badResponse;
        
    }
    
    @isTest
    static void textSimilarityTest(){
        //Set mock callout class
        Test.setMock(HttpCalloutMock.class, new comparePanelAnswersControllerMock());

        Decimal response = ComparePanelAnswersController.textSimilarity('The hippocampus is a major component of the brains of humans and other vertebrates. It belongs to the limbic system and plays important roles in the consolidation of information from short-term memory to long-term memory and spatial navigation. Humans and other mammals have two hippocampi, one in each side of the brain. The hippocampus is a part of the cerebral cortex; and in primates it is located in the medial temporal lobe, underneath the cortical surface. It contains two main interlocking parts: Ammon\'s horn and the dentate gyrus.',
        'An important part of the brains of humans and other vertebrates is the hippocampus. It\'s part of the limbic system and moves information from short-term to long-term memory. It also helps us move around. Humans and other mammals have two hippocampi, one on each side. The hippocampus is a part of the cerebral cortex; and in primates it is found in the medial temporal lobe, beneathe the cortical surface. It has two main interlocking parts: Ammon\'s horn and the dentate gyrus.');
        System.debug(response);
        //verify response
        Decimal expectedValRaw = 0.86882813106215;
        Decimal expectedValFixed = (expectedValRaw*100).setScale(2);
        System.assertEquals(expectedValFixed, response);
    }

    @isTest
    static void getBestResponseTest(){
        comparePanelAnswersTest.makeQuestionResponses();

        Question__c question = [SELECT Id FROM Question__c];
        List<Question_Response__C> qResponses = [SELECT Id, Name, Total_Rating__C FROM Question_Response__C];

        Test.startTest();
        Question_Response__c returnResponse = ComparePanelAnswersController.getBestResponse(question.Id);
        system.assert(returnResponse.Name == qResponses[0].Name);
        system.assert(returnResponse.Name != qResponses[1].Name);

        Test.stopTest();
    }

}