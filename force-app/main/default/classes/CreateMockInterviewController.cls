public without sharing class CreateMockInterviewController {
    public static List<Question__c> getQuestionList(Integer numQuestions, List<String> filter){

        if (numQuestions==null) {
            List<Question__c> emptyList = new List<Question__c>();
            return emptyList;
        }

        Integer remainder = Math.mod(numQuestions, filter.size());
        System.debug(remainder);
        Integer dividend = Math.floor(numQuestions/filter.size()).intValue();
        System.debug(dividend);
        //Map<String, List<Question__c>> outputListConstructor = new Map<String, List<Question__c>>();
        Map<String, List<Question__c>> qListMap = new Map<String, List<Question__c>>();
        for (String s : filter) {
            List<Question__c> tempList = new List<Question__c>();
            //outputListConstructor.put(s, tempList);
            qListMap.put(s,tempList);
        }
        //List<Question__c> remainderList = new List<Question__c>();
        //outputListConstructor.put('remainder', remainderList);
        for (Question__c q : [SELECT Body__c,Name, Type__c FROM Question__c WHERE type__c IN :filter]) {
            for (String s : filter) {
                if (s==q.Type__c) {
                    qListMap.get(s).add(q);
                }
            }
        }
        List<Question__c> outputList = new List<Question__c>();
        Integer counter=0;
        Integer listItemCounter = 0;
        Integer whichList = 0;
        Integer questionLocation;
        while(counter<numQuestions-remainder){
            if (listItemCounter<dividend) {
                questionLocation=Math.floor(Math.random() * qListMap.get(filter[whichList]).size()).intValue();
                outputList.add(qListMap.get(filter[whichList])[questionLocation]);
                qListMap.get(filter[whichList]).remove(questionLocation);
                listItemCounter++;
                counter++;
            }else{
                listItemCounter=0;
                whichList++;
            }
            
        }
        for(Integer i=0; i<remainder; i++){
            questionLocation=Math.floor(Math.random() * qListMap.get(filter[i]).size()).intValue();
            outputList.add(qListMap.get(filter[i])[questionLocation]);
            qListMap.get(filter[i]).remove(questionLocation);
        }
        return outputList;
    }
    @AuraEnabled
    public static void createMockInterview(Integer numQuestions, List<String> filter){
        List<Question__c> questionsToBeAdded = new List<Question__c>();
        ID userId = System.UserInfo.getUserId();
        System.debug(userId);
        //return userId;
       // Id userId = '0053h000003gNSiAAM' contact id = 0033h000009tdoyAAA;
        User userContactId = [Select Name, Contact.id FROM USER WHERE ID = :userId] ;
        system.debug(userContactId);
        questionsToBeAdded = CreateMockInterviewController.getQuestionList(numQuestions,filter);
        Id recordTypeId = Schema.SObjectType.Meeting__c.getRecordTypeInfosByName().get('Mock Interview').getRecordTypeId();

        Integer x = [SELECT Count() FROM Meeting__c WHERE recordTypeId=:recordTypeId];
        x+=1;

        Meeting__c mockInterview = new Meeting__c(Name=  'Mock interview #' + x + ' with ' +numQuestions+' questions',
                                                    Meeting_Status__c='Mock',
                                                    RecordTypeId=recordTypeId);
        Database.SaveResult savedInterview = Database.insert(mockInterview);
        Id interviewId = savedInterview.getId();
        Meeting_Participant__c meetParti = new Meeting_Participant__c(Meeting__c = interviewId,
                                                                     Participant__c = userContactId.ContactId);
        insert meetParti;
            List<Interview_Question__c> interviewQuestions = new List<Interview_Question__c>();
            for (Question__c q : questionsToBeAdded) {
                Interview_Question__c addedQuestion = new Interview_Question__c(Meeting_md__c=interviewId,
                                                                                Question__c=q.Id);
                interviewQuestions.add(addedQuestion);
        }
        insert interviewQuestions;
       
        //insert interviewQuestions;
        
        
    }

    @AuraEnabled
    public static Map<String,List<String>> getTypePicklistValues() {
        return Utilities.getTypePicklistValues();
    }

    //Twinword API Callout for answer comparison
    @AuraEnabled
    public static String textSimilarity(String mockInterviewResponse, String bestCommunityAnswer) {
        System.debug('Accessed vesselSearch in Apex Controller');
        
        //pass in inputed description for translation
        //Build PARAMETERS:
        
        String rapidApiHost = 'twinword-text-similarity-v1.p.rapidapi.com';
        String rapidApiKey = 'SIGN-UP-FOR-KEY'; //must subscribe for key
        String rapidApiContentType = 'application/x-www-form-urlencoded';

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
        String klingonOutput;
        Map<String,Object> translation = new Map<String,Object>();
        
        if(response.getStatus() == 'OK'){
            translation = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
            System.debug(translation);
            Map<String, Object> contentsMap = (Map<String, Object>)translation.get('contents');
            klingonOutput = String.valueOf(contentsMap.get('translated'));
            System.debug(klingonOutput); //this worked as of 154PM 10/26/2020
        } else {
            System.debug('could not retrieve transalation');
        }
        
        //write translation to the Attribute via return:
    	return klingonOutput;
	}    
    
}