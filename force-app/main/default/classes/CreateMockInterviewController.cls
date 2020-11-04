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


    //Added by Red Team. Might have to move this to a different controller
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
   
        
    //added by Paul on 10/29/2020

    //Method specific to the CreateMockPanel aura component for selecting a specified number of questions
    //at random from each selected topic.
    //The tentative plan is to use similar logic as they used for filtering questions but instead of using a list of the 
    //filter strings we plan to use a map that will store the topic filter and the number of questions for a specified topic as
    //key-value pairs

    @AuraEnabled
    public static List<Question__c> getNumQuestionListByTopic(List<Map<String, Object>> filterPanel){
        //Exits the function if the there are no key value pairs and returns no questions
        if(filterPanel.isEmpty()== true) {
            List<Question__c> emptyPanelList= new List<Question__c>();
            return emptyPanelList;
        }

        //method for iterating through maps 
        //filterPanel.keyset creates a set of the keys in our map<key,value> pair that we can iterate through to grab the number of panel questions
        //Set<String> questionTop = filterPanel.keyset(); 
        List<String> questionTopics = new List<String>();
        List<Integer> topicNumber = new List<Integer>();
        
        //for(String s : questionTop) {
        //    questionTopics.add(s);
        //}
        for(Map<String, Object> a : filterPanel) {
            questionTopics.add(String.valueOf(a.get('name')));
            topicNumber.add(Integer.valueOf(a.get('number')));
        }

            //Creates a map of the selected topics and related questions
            Map<String, List<Question__c>> panel_QListMap = new Map<String, List<Question__c>>();
            //iterates through the questionTopics set we made earlier and uses it to create a key value pair with an empty List of questions
            for (String s : questionTopics) {
                List<Question__c> tempList = new List<Question__c>();
                //outputListConstructor.put(s, tempList);
                panel_QListMap.put(s,tempList);
            }

            //This for loop should iterate through our set of questionTopics and grabs all the questions from that topic
            for (String s : questionTopics) {
                for(Question__c q : [SELECT Name, Body__c, Type__c FROM Question__c WHERE type__c =:s])
                    panel_QListMap.get(s).add(q);
            }
            /*
                we now have a list of questions for each topic all that remains now is to filter each list of 
              questions for a given topic down to the specified number of questions for each topic
            */

            //List of questions for the panel session
            //This will be the question list that will appear in the simulated panel
            List<Question__c> panelOutputList = new List<Question__c>();
            
            Integer counter=0;
            //Integer listItemCounter = 0;
            Integer whichList = 0;
            Integer questionLocation;
            
            
            for(Integer numPanelQuestions : topicNumber) {
                counter = 0;
                //grabs the integer value of the number of questions for a specific topic                
                while(counter<numPanelQuestions){          //While the counter is less than numPanelQuestions
                    //Choose a random number for the question location 
                    //for panel_QListMap.get the filter panel must be type list
                    questionLocation=Math.floor(Math.random() * panel_QListMap.get(questionTopics[whichList]).size()).intValue();
                    //Adds the random question to the output list 
                    panelOutputList.add(panel_QListMap.get(questionTopics[whichList])[questionLocation]);
                    //Removes the question so it is no repeats are added
                    panel_QListMap.get(questionTopics[whichList]).remove(questionLocation);
                    //listItemCounter++;
                    counter++;
                }

                //listItemCounter=0;
                whichList++;
                    
                
            }

        //Returns our question bank sorted by topic with a specific number of questions
        return panelOutputList;
    }

    //Additional feature added on 11/4/2020 by Paul

    //Adding an enhanced for loop to save the list of questions stored in panelOutputList to the
    //Panel_Question__c object the implementation should be fairly straight forward
    @AuraEnabled
    public static void CreateMockPanel(List<Map<String,Object>> filterPanel){
        //Creates list of questions to be added to Panel_Question__c junction object
        List<Question__c> panelQuestionsToBeAdded = new List<Question__c>();
        
        //Might need to assign owner id to newly created Mock_Panel__c later on
        ID userId = System.UserInfo.getUserId();

        //Returns the list of questions to be included in the Mock Panel
        panelQuestionsToBeAdded = CreateMockInterviewController.getNumQuestionListByTopic(filterPanel);

        //creates new mock panel to relate to panel questions added
        Mock_Panel__c mockPanel = new Mock_Panel__c(OwnerId = userId);
        insert mockPanel;

        //List of junction object panel questions
        List<Panel_Question__c> panelQuestions = new List<Panel_Question__c>();
        //Iterates through questions list created earlier and creates the junction object between them and the 
        //new Mock_Panel__c
        for(Question__c q : panelQuestionsToBeAdded) {
            Panel_Question__c addedPanelQuestion = new Panel_Question__c(Mock_Panel__c = mockPanel.Id,
                                                                         Question__c = q.Id);
            panelQuestions.add(addedPanelQuestion);
        }
        //Creates new panel questions associated with a Mock_Panel__c
        insert panelQuestions;
    }

    
    @AuraEnabled
    public static List<Integer> getNumberOfQuestionType(List<String> filter) {
        System.debug(filter);
        List<Integer> result = new List<Integer>();
        for(Integer i = 0; i < filter.size(); i++) {
            result.add(0);
        }
        for(Question__c a : [SELECT Id, type__c FROM Question__c WHERE type__c=:filter]) {
            for(Integer i = 0; i < filter.size(); i++) {
                if(a.type__c == filter[i]) {
                    result[i] += 1;
                }
            }
        }

        return result;
    }
}