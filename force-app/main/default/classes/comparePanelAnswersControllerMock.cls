@isTest
global class comparePanelAnswersControllerMock implements HttpCalloutMock{
    public HttpResponse respond(HttpRequest request){
        String rapidApiHost = 'twinword-text-similarity-v1.p.rapidapi.com';
        String rapidApiKey = '5057c9cd5cmsh4cb024048d6b1d1p174225jsn95e2c534eed4'; //must subscribe for key
        String rapidApiContentType = 'application/x-www-form-urlencoded';
        //Fake Response
        HttpResponse response = new HttpResponse();
        response.setHeader('x-rapidapi-host', rapidApiHost);
        response.setHeader('x-rapidapi-key', rapidApiKey);
        response.setHeader('content-type', rapidApiContentType);
        response.setBody('{"author":"twinword inc.","email":"help@twinword.com","result_code":"200","result_msg":"Success","similarity":0.86882813106215,"value":2463079.7207981,"version":"4.0.0"}');
        response.setStatus('OK');
        Return response;
    }

    /*@isTest
    static void textSimilarityTest(){
        //Set mock callout class
        Test.setMock(HttpCalloutMock.class, new comparePanelAnswersControllerTest());

        Decimal response = CreateMockInterviewController.textSimilarity('The hippocampus is a major component of the brains of humans and other vertebrates. It belongs to the limbic system and plays important roles in the consolidation of information from short-term memory to long-term memory and spatial navigation. Humans and other mammals have two hippocampi, one in each side of the brain. The hippocampus is a part of the cerebral cortex; and in primates it is located in the medial temporal lobe, underneath the cortical surface. It contains two main interlocking parts: Ammon\'s horn and the dentate gyrus.',
        'An important part of the brains of humans and other vertebrates is the hippocampus. It\'s part of the limbic system and moves information from short-term to long-term memory. It also helps us move around. Humans and other mammals have two hippocampi, one on each side. The hippocampus is a part of the cerebral cortex; and in primates it is found in the medial temporal lobe, beneathe the cortical surface. It has two main interlocking parts: Ammon\'s horn and the dentate gyrus.');
        //verify response
        Decimal expectedValRaw = 0.86882813106215;
        Decimal expectedValFixed = (expectedValRaw*100).setScale(2);
        System.assertEquals(expectedValFixed, response);
    }*/
}