public class InterviewQuestions { 

    @AuraEnabled
    public static List<Meeting__c> getMeetings() {
        return [SELECT Id, Name FROM Meeting__c]; 
    }

    @AuraEnabled
    public static List<Interview_Question__c> getQuestions(Id meetingId) {
        return [SELECT Id, Subject__c, Body__c, Name, Meeting__c 
            FROM Interview_Question__c WHERE Meeting__c = :meetingId ORDER BY CreatedDate DESC];
    }
    
}