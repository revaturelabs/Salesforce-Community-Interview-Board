public class ComparePanelAnswersController {
    public ComparePanelAnswersController() {

    }
    //Added by Red Team.
    //Twinword API Callout for answer comparison
    @AuraEnabled
    public static Decimal textSimilarity(String mockInterviewResponse, String bestCommunityAnswer) {
        System.debug('Accessed vesselSearch in Apex Controller');
        
        //pass in inputed description for translation
        //Build PARAMETERS:
        
        String rapidApiHost = 'twinword-text-similarity-v1.p.rapidapi.com';
        String rapidApiKey = '5057c9cd5cmsh4cb024048d6b1d1p174225jsn95e2c534eed4'; //must subscribe for key
        String rapidApiContentType = 'application/x-www-form-urlencoded';
        String rapidApiEndpoint = 'https://rapidapi.p.rapidapi.com/similarity/';

        /*	body sent must look like this: "text1=
                            The%20hippocampus%20is%20a%20major%20component%20of%20the%20brains%20of%20humans%20and%20other%20vertebrates.%20
                            It%20belongs%20to%20the%20limbic%20system%20and%20plays%20important%20roles%20in%20the%20consolidation%20of%20
                            information%20from%20short-term%20memory%20to%20long-term%20memory%20and%20spatial%20navigation.%20Humans%20
                            and%20other%20mammals%20have%20two%20hippocampi%2C%20one%20in%20each%20side%20of%20the%20brain.%20The%20hippocampus%20
                            is%20a%20part%20of%20the%20cerebral%20cortex%3B%20and%20in%20primates%20it%20is%20located%20in%20the%20medial%20
                            temporal%20lobe%2C%20underneath%20the%20cortical%20surface.%20It%20contains%20two%20main%20interlocking%20parts%3A%20
                            Ammon's%20horn%20and%20the%20dentate%20gyrus.
                        &text2=
                            An%20important%20part%20of%20the%20brains%20of%20humans%20and%20other%20vertebrates%20is%20the%20hippocampus.%20
                            It's%20part%20of%20the%20limbic%20system%20and%20moves%20information%20from%20short-term%20to%20long-term%20
                            memory.%20It%20also%20helps%20us%20move%20around.%20Humans%20and%20other%20mammals%20have%20two%20hippocampi%2C%20
                            one%20on%20each%20side.%20The%20hippocampus%20is%20a%20part%20of%20the%20cerebral%20cortex%3B%20and%20in%20
                            primates%20it%20is%20found%20in%20the%20medial%20temporal%20lobe%2C%20beneathe%20the%20cortical%20surface.%20
                            It%20has%20two%20main%20interlocking%20parts%3A%20Ammon's%20horn%20and%20the%20dentate%20gyrus."
        */        
        mockInterviewResponse = mockInterviewResponse.replaceAll(' ', '%20');
            //System.debug(mockInterviewResponse);
        bestCommunityAnswer = bestCommunityAnswer.replaceAll(' ', '%20');
            //System.debug(bestCommunityAnswer);
        String rapidApiBody = 'text1=' + mockInterviewResponse + '&text2=' + bestCommunityAnswer;
        //System.debug(rapidApiBody);
        
        //Callout to the API
        Http h = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(rapidApiEndpoint);
        request.setHeader('x-rapidapi-host', rapidApiHost);
        request.setHeader('x-rapidapi-key', rapidApiKey);
	    request.setHeader('content-type', rapidApiContentType);         
        request.setBody(rapidApiBody);
        request.setMethod('POST');
        HttpResponse response = h.send(request);
        //System.debug(response);

        /*	Response will look like:
                {7 items
                "author":"twinword inc."
                "email":"help@twinword.com"
                "result_code":"200"
                "result_msg":"Success"
                "similarity":0.86882813106215
                "value":2463079.7207981
                "version":"4.0.0"
                }
        */

        //Change parsing once we are connected to Org and testing.       
        //Parsing/Translating the JSON return
        // String klingonOutput;
        // Map<String,Object> translation = new Map<String,Object>();

        Decimal rapidApiScore;
        
        if(response.getStatus() == 'OK'){
            // translation = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
            Map<String, Object> rapidApiParsed = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            rapidApiScore = ((Decimal)rapidApiParsed.get('similarity') * 100).setScale(2);
            System.debug(rapidApiParsed);
            System.debug(rapidApiScore);
            // Map<String, Object> contentsMap = (Map<String, Object>)translation.get('contents');
            // klingonOutput = String.valueOf(contentsMap.get('translated'));
            // System.debug(klingonOutput); //this worked as of 154PM 10/26/2020
        } else {
            System.debug('could not retrieve transalation');
        }
        
        //write translation to the Attribute via return:
    	return rapidApiScore;
    }
    
    @AuraEnabled
    public static string getBestResponse(Id questionId){
        //Get current question
        //Question__c question = [SELECT Id, Body__c FROM Question__c WHERE Id = :questionId];

        //Match this questionId to related ratings and picked the highest one
        /* List<Question_Response__c> questionResponses = [SELECT Id, Body__c, MAX(Upvotes__c) maxUpvotes FROM Question_Response__c WHERE Question__r.Id = :questionId ORDER BY Total_Votes__c DESC];
        Question_Response__c bestResponse = new QuestionResponse();
        for(Question_Response__C qR : questionResponses){
            if(qR.Upvotes__c == maxUpvotes){
                bestResponse = qR;
                break;
            }
        } */
        Question_Response__c bestResponse = [SELECT Id, Body__c , Upvotes__c FROM Question_Response__c WHERE Question__r.Id = :questionId ORDER BY Upvotes__c DESC LIMIT 1];
        system.debug('GetBestResponse Debug ' +bestResponse.Body__c);
        Return bestResponse.Body__c;

    }
}
