public class AssociateMeetingController {
    
    @auraenabled
    public static Meeting__c[] GetUpcomingMeetings() {
        //returns all future meetings the logged in associate is a participant of that arent mock interviews
        list<Meeting__c>  meetinglist = new    list<Meeting__c>{}; 
            try {
                ID userId = System.UserInfo.getUserId();
                ID userContactId = [Select Contact.id FROM USER WHERE ID = :userId].contactId ;

                Id MockId = Schema.SObjectType.Meeting__c.getRecordTypeInfosByName().get('Mock Interview').getRecordTypeId();
                meetinglist=  [SELECT Id, Name, Client_Name__c , Meeting_status__c , Scheduled__c , location__c, Notes__c, Display_Name__c
                               FROM Meeting__c
                               WHERE Id IN (SELECT Meeting__c 
                                            FROM Meeting_Participant__c 
                                            WHERE Participant__c  = :userContactId
                                           ) AND Scheduled__c > : System.now() AND RecordTypeId != : MockId ORDER BY Scheduled__c  ];
            } catch(Exception e) {
                throw new AuraHandledException('Server-side Error: ' + e.getMessage()); 
            }
        
        return meetinglist;
        
        
    }


    @auraenabled
    public static Meeting__c[] GetUpcomingMeetingsAll() {
        //returns all future meetings the logged in associate is a participant of that arent mock interviews
        list<Meeting__c>  meetinglist = new    list<Meeting__c>{}; 
            try {

                Id MockId = Schema.SObjectType.Meeting__c.getRecordTypeInfosByName().get('Mock Interview').getRecordTypeId();
                meetinglist=  [SELECT Id, Name, Client_Name__c , Meeting_status__c , Scheduled__c , location__c, Notes__c, Display_Name__c
                               FROM Meeting__c
                               WHERE Id IN (SELECT Meeting__c 
                                            FROM Meeting_Participant__c 
                                           ) AND Scheduled__c > : System.now() AND RecordTypeId != : MockId ORDER BY Scheduled__c  ];
            } catch(Exception e) {
                throw new AuraHandledException('Server-side Error: ' + e.getMessage()); 
            }
        
        return meetinglist;
        
        
    }
    
    @auraEnabled
    public static Meeting__c[]  GetFutureMockInterviews() {
        //returns all mock interviews
        list<Meeting__c>  meetinglist = new    list<Meeting__c>{}; 
            try {
                ID userId = System.UserInfo.getUserId();
                ID userContactId = [Select Contact.id FROM USER WHERE ID = :userId].contactId ;

                Id MockId = Schema.SObjectType.Meeting__c.getRecordTypeInfosByName().get('Mock Interview').getRecordTypeId();
                meetinglist=  [SELECT Id, Name, Notes__c, Display_Name__c
                               FROM Meeting__c
                               WHERE Id IN (SELECT Meeting__c 
                                            FROM Meeting_Participant__c 
                                            WHERE Participant__c  = :userContactId
                                           )  AND RecordTypeId = : MockId   ];
                
            } catch(Exception e) {
                throw new AuraHandledException('Server-side Error: ' + e.getMessage()); 
            }
        
        return meetinglist;
    }
    
    //returns all interviews that are completed, past their schedule time, and of interview batch and interview 1-1 record type
    @auraEnabled
    public static Meeting__c[]  GetPastInterviews(){
        list<Meeting__c> meetinglist = new list<Meeting__c>(); 
            try {
                ID userId = System.UserInfo.getUserId();
                ID userContactId = [Select Contact.id FROM USER WHERE ID = :userId].contactId ;
                
                //Allow an admin to view all
                ID profileId = System.userInfo.getProfileId();
                ID adminProfileId = [SELECT Id FROM Profile WHERE Name='System Administrator'].id;
                	//System.debug('profile: ' + profileId + '\nadmin: ' + adminProfileId + '\nallVisible: ' + allVisible);
                
                //If the user is an admin, new SOQL query to return all completed Interviews
                if(profileId == adminProfileId){
                    meetingList = [SELECT Id, Name, Notes__c, Display_Name__c, Feedback__c, addQuestionVisibility__c, completed__c
                                   FROM Meeting__c WHERE Meeting_Status__c = 'Completed'];
                } else {
                 	//make list of record types we wish to retrieve as parameter for SOQL query
                    list<ID> rectypelist = new list<id>{
                        Schema.SObjectType.Meeting__c.getRecordTypeInfosByName().get('Interview Batch').getRecordTypeId(),
                        Schema.SObjectType.Meeting__c.getRecordTypeInfosByName().get('Interview 1-1').getRecordTypeId()
                    };
                    meetinglist=  [SELECT Id, Name, Notes__c, Display_Name__c, Feedback__c, addQuestionVisibility__c , Completed__c
                                   FROM Meeting__c
                                   WHERE Id IN (SELECT Meeting__c FROM Meeting_Participant__c 
                                                 WHERE Participant__c  = :userContactId)
                                          AND RecordTypeId IN :rectypelist 
                                          AND Scheduled__c < : system.now() 
                                          AND Meeting_Status__c = 'Completed'
                                   ];
                }
            }catch(Exception e){
                throw new AuraHandledException('Server-side Error: ' + e.getMessage()); 
            }
        system.debug(meetinglist);
        return meetinglist;
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

    @auraenabled
    public static void attachQuestionsToMeeting(Id[] idList, String meeting) {

        Meeting__c meet = [SELECT id, name FROM Meeting__c WHERE name =: meeting];
        try {
            for(Id qID : idList)
            {
                List<Interview_Question__c> searchIQ = [SELECT id, Meeting_md__c, Question__c FROM Interview_Question__c WHERE Meeting_md__c =: meet.id AND Question__c =: qID];

                if(searchIQ.size() == 0)
                {
                    Interview_Question__c iq = new Interview_Question__c(Meeting_md__c = meet.id, Question__c=qID);
                    insert iq;
                }
                
            }
        } catch(Exception e) {
                throw new AuraHandledException('Server-side Error: ' + e.getMessage()); 
        }

        return;
    }
}