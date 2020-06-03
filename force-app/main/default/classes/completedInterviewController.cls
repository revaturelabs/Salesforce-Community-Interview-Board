public with sharing class completedInterviewController {
    @AuraEnabled
    public static List<Meeting__c> getMeetings(String AId) {
        list<Meeting_participant__C> MPList= [SELECT Meeting__C from Meeting_Participant__C where Participant__C = :AId];
        list<Meeting__C> MList = new List<Meeting__C>();
        //MList = [SELECT Name, Completed_Date__c, Participating_Client__c, Meeting_Status__c FROM Meeting__c WHERE Id = :MP.Meeting__c AND Meeting_Status__c = :'Completed' LIMIT 1];

        
        for(Meeting_Participant__C MP : MPList){
            Meeting__C C = [SELECT Name, Completed_Date__c, Client_Name__c, Meeting_Status__C FROM Meeting__c WHERE Id = :MP.Meeting__c LIMIT 1];
            if(c.Meeting_Status__c == 'Completed'){
                MList.add(C);
            }
        }
        
        system.debug(mlist);
        return MList;
    }
}