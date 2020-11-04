@isTest
public class comparePanelAnswersTest {
    
    @isTest
    static void textSimilarityTest(){
        //Set mock callout class
        Test.setMock(HttpCalloutMock.class, new comparePanelAnswersControllerMock());

        Decimal response = CreateMockInterviewController.textSimilarity('The hippocampus is a major component of the brains of humans and other vertebrates. It belongs to the limbic system and plays important roles in the consolidation of information from short-term memory to long-term memory and spatial navigation. Humans and other mammals have two hippocampi, one in each side of the brain. The hippocampus is a part of the cerebral cortex; and in primates it is located in the medial temporal lobe, underneath the cortical surface. It contains two main interlocking parts: Ammon\'s horn and the dentate gyrus.',
        'An important part of the brains of humans and other vertebrates is the hippocampus. It\'s part of the limbic system and moves information from short-term to long-term memory. It also helps us move around. Humans and other mammals have two hippocampi, one on each side. The hippocampus is a part of the cerebral cortex; and in primates it is found in the medial temporal lobe, beneathe the cortical surface. It has two main interlocking parts: Ammon\'s horn and the dentate gyrus.');
        System.debug(response);
        //verify response
        Decimal expectedValRaw = 0.86882813106215;
        Decimal expectedValFixed = (expectedValRaw*100).setScale(2);
        System.assertEquals(expectedValFixed, response);
    }

}