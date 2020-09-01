public class MeetingController {

    
    //Method that checks whether the user has the custom Permission assigned to their Profile -- Returns true if they do
    @AuraEnabled
    public static Boolean getProfilePerm(){

        Boolean AssociatePerm = FeatureManagement.checkPermission('AssociatePermission');
        return AssociatePerm;
    }
    
    @AuraEnabled
    public static String getMeeting(){
        Meeting__c testMeeting = [SELECT id, name, StartDateTime__c, EndDateTime__c, Meeting_Status__c FROM Meeting__c Limit 1];
        String meetingId = testMeeting.id;
        return meetingId;
        
    }
    
}