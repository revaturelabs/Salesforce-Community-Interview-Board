public with sharing class MockInterviewLauncher {
    public MockInterviewLauncher() {

    }
    @auraenabled
    public static List<Interview_Question__c> GetInterviewQuestions(String meetingid) {
        //returns all interview_question objects that are related to the parameter meetingid 
        List<Interview_Question__c> returnlist = new List<Interview_Question__c>{};

        try {
            //name, body__c fields removed as these are no longer used on the Interview_Question__c object
            returnlist = [SELECT id FROM Interview_Question__c WHERE Meeting_md__c = : meetingid];
        
        } catch(Exception e) {
                throw new AuraHandledException('Server-side Error: ' + e.getMessage()); 
        }

        return returnlist;
    }
}
