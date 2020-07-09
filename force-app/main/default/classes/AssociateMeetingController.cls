public class AssociateMeetingController {
    
    @auraenabled
    public static Meeting__c[] GetUpcomingMeetings()
    {//returns all future meetings the logged in associate is a participant of that arent mock interviews
        
        
        
        list<Meeting__c>  meetinglist = new    list<Meeting__c>{}; 
            try {
                ID userId = System.UserInfo.getUserId();
                User userContactId = [Select Contact.id FROM USER WHERE ID = :userId] ;
                Id MockId = Schema.SObjectType.Meeting__c.getRecordTypeInfosByName().get('Mock Interview').getRecordTypeId();
                meetinglist=  [SELECT Id, Name, Client_Name__c , Meeting_status__c , Scheduled__c , location__c, Notes__c, Display_Name__c
                               FROM Meeting__c
                               WHERE Id IN (SELECT Meeting__c 
                                            FROM Meeting_Participant__c 
                                            WHERE Participant__c  = :userContactId.ContactId
                                           ) AND Scheduled__c > : System.now() AND RecordTypeId != : MockId ORDER BY Scheduled__c  ];
            }catch(Exception e){
                throw new AuraHandledException('Server-side Error: ' + e.getMessage()); 
            }
        
        return meetinglist;
        
        
    }
    
    @auraEnabled
    public static Meeting__c[]  GetFutureMockInterviews()
    {//returns all upcoming mock interviews
        
        
        
        list<Meeting__c>  meetinglist = new    list<Meeting__c>{}; 
            try {
                ID userId = System.UserInfo.getUserId();
                User userContactId = [Select Contact.id FROM USER WHERE ID = :userId] ;
                Id MockId = Schema.SObjectType.Meeting__c.getRecordTypeInfosByName().get('Mock Interview').getRecordTypeId();
                meetinglist=  [SELECT Id, Name, Notes__c, Display_Name__c
                               FROM Meeting__c
                               WHERE Id IN (SELECT Meeting__c 
                                            FROM Meeting_Participant__c 
                                            WHERE Participant__c  = :userContactId.ContactId
                                           )  AND RecordTypeId = : MockId   ];
                
            }catch(Exception e){
                throw new AuraHandledException('Server-side Error: ' + e.getMessage()); 
            }
        
        return meetinglist;
    }
    
    
}