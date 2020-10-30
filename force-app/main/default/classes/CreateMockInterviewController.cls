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
<<<<<<< HEAD

        
    //added by Paul on 10/29/2020

    //Method specific to the CreateMockPanel aura component for selecting a specified number of questions
    //at random from each selected topic.
    //The tentative plan is to use similar logic as they used for filtering questions but instead of using a list of the 
    //filter strings we plan to use a map that will store the topic filter and the number of questions for a specified topic as
    //key-value pairs

    @AuraEnabled
    public static List<Question__c> getNumQuestionListByTopic(Map<String, Integer> filterPanel){
        
        //Exits the function if the there are no key value pairs and returns no questions
        if(filterPanel.isEmpty()== true) {
            List<Question__c> emptyPanelList= new List<Question__c>();
            return emptyPanelList;
        }

        //method for iterating through maps 
        //filterPanel.keyset creates a set of the keys in our map<key,value> pair that we can iterate through to grab the number of panel questions
        Set<String> questionTop = filterPanel.keyset(); 
        List<String> questionTopics = new List<String>();
        
        for(String s : questionTop) {
            questionTopics.add(s);
        }
        
        /*Ignore this section of commented out code for now
        
        for(String questionTopics : filterPanel.keyset()) {
            Integer numPanelQuestions = filterPanel.get(questionTopics);
        }
            Integer panelRemainder = Math.mod(numQuestions, filter.size()); filter.size doesn't apply
            System.debug(remainder);
            Integer dividend = Math.floor(numQuestions/filter.size()).intValue();
            System.debug(dividend);
            */

            //Creates a map of the selected topics and related questions
            Map<String, List<Question__c>> panel_QListMap = new Map<String, List<Question__c>>();
            //iterates through the questionTopics set we made earlier and uses it to create a key value pair with an empty List of questions
            for (String s : questionTopics) {
                List<Question__c> tempList = new List<Question__c>();
                //outputListConstructor.put(s, tempList);
                panel_QListMap.put(s,tempList);
            }

            //The outer for loop iterates through a list of questions where the type is a string in the set<> question topics 
            //previous gen code for getting list of questions by topics but fuck themand their methods something about
            //this seems like it won't work for our situation
            /*
            for (Question__c q : [SELECT Body__c,Name, Type__c FROM Question__c WHERE type__c IN :questionTopics]) {
                for (String s : questionTopics) {
                    if (s==q.Type__c) {
                        qListMap.get(s).add(q);
                    }
                }
            }
            */

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
            
            
            for(String qT : filterPanel.keyset()) {
                //grabs the integer value of the number of questions for a specific topic
                Integer numPanelQuestions = filterPanel.get(qT); 
                
                while(counter<numPanelQuestions){          //While the counter is less than numPanelQuestions
                //if (listItemCounter<dividend) {        this line counts until the number of questions is not applicable to us 
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
            /*
            Is used for the remainder when you are dividing the questions equally which does not apply to this panel code    
                for(Integer i=0; i<remainder; i++){
                    questionLocation=Math.floor(Math.random() * qListMap.get(filter[i]).size()).intValue();
                    outputList.add(qListMap.get(filter[i])[questionLocation]);
                    qListMap.get(filter[i]).remove(questionLocation);
                }
            */
        //Returns our question bank sorted by topic with a specific number of questions
        return panelOutputList;
    }

    //Since we don't currently plan to use panel_session objects to create a panel session this 
    //doesn't seem to be necessary
    /*
    @AuraEnabled
    public static void CreateMockPanelSession(Map<String, Integer> filterPanel) {
        List<Question__c> panelQuestionsToBeAdded = new List<Question__c>();
        ID userId = System.UserInfo.getUserId();
        System.debug(userId);
        //return userId;
       // Id userId = '0053h000003gNSiAAM' contact id = 0033h000009tdoyAAA;
       User userContactId = [Select Name, Contact.id FROM USER WHERE ID = :userId] ;
       system.debug(userContactId);
       panelQuestionsToBeAdded = CreateMockInterviewController.getNumQuestionListByTopic(filterPanel);
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
   }
   */
=======
    
    @AuraEnabled
    public static List<Integer> getNumberOfQuestionType(List<String> filter) {
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
        for(Integer i = 0 ; i < result.size(); i++) {
            System.debug(filter[i] + ' : ' +result[i]);
        }
        return result;
    }
>>>>>>> 354902e1367f19d28ba22babd157cab8c7f10968
}