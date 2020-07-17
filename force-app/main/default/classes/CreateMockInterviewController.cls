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
        Meeting__c mockInterview = new Meeting__c(Name= 'Mock interview with '+numQuestions+' questions',
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
}