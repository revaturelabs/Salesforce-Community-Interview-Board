public with sharing class MeetingController{

    
    //Method that checks whether the user has the custom Permission assigned to their Profile -- Returns true if they do
    @AuraEnabled
    public static Boolean getProfilePerm(){

        Boolean AdminPerm = FeatureManagement.checkPermission('AdminPermission');
        return AdminPerm;
    }
    
    @AuraEnabled
    public static String getMeeting(){
        Meeting__c testMeeting = [SELECT id, name, StartDateTime__c, EndDateTime__c, Meeting_Status__c, Google_Event_Id__c FROM Meeting__c Limit 1];
        String meetingId = testMeeting.id;
        return meetingId;
        
    }
    
}