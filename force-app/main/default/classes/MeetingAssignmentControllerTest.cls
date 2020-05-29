@isTest
public class MeetingAssignmentControllerTest {
	/**Test Setup **********************************************************************************/
  /*  @testSetup static void makeTestData() {
        List <Meeting__c> testMeetings = new List <Meeting_c>();
        for (Integer i=0; i<5; i++){
            testMeetings.add(new Meeting__c);
            Name = ('Meeting' + i);
        }
        insert testMeetings;

        List<Contact> testAssociates = new List <Contact>();
        for (Integer i=0; i<5; i++){
            testAssociates.add(new Contact);
            Name = ('Associate' + i);
            RecordType = 'Associate'
        }
        insert testAssociates;

        List<Account> testBatches = new List <Account>();
        for(Integer i=0; i<5; i++){
            testBatches.add(new Account);
            Name = ('Batch'+ i );
            RecordType = 'Batch'
        }
        insert testBatches;*/
    /**End Test Setup */
	
    /**Test getMeetingTest**************************************************************************/
    @isTest(seeAllData=true)
    public static void getMeetingTest(){
        System.debug('Testing getMeetings without participant');
        List<Meeting__c> meetingsByBatch=  MeetingAssignmentController.getMeetings('Batch 3', '');
        System.debug(meetingsByBatch);
        RecordType RT = [SELECT Name, Id FROM RecordType WHERE sObjectType='Meeting__c' AND Name='Interview Batch'];
        RecordType RT2 = [SELECT Name, Id FROM RecordType WHERE sObjectType='Meeting__c' AND Name='Intervention Batch'];
       Boolean test;
        for (Meeting__c meeting: meetingsByBatch)
        {            
			if (meeting.RecordTypeId==RT.Id | meeting.RecordTypeId==RT2.Id)
            {
                test=true;
            }
            else
            {
                test=false;
            }
            System.assert(test, meetingsByBatch.contains(meeting));
        }
        System.debug('Finished test getMeetings without participant');
		System.debug('Testing getMeetings with participant');        
        String associate = 'Batch2 Contact 1';
		List<Meeting__c> meetingsByAssociate = MeetingAssignmentController.getMeetings('Batch 2', associate);
        System.debug(meetingsByAssociate);
        List<Meeting__c> testList = [SELECT Name, (SELECT Participant__r.Name FROM Meeting_Participants__r) FROM Meeting__c];
        for (Meeting__c meeting: testList)
        {
           for(Meeting_Participant__c participant : meeting.Meeting_Participants__r)
           {
               if (participant.Participant__r.Name == associate)
               {
               System.assert(true, meetingsByAssociate.contains(meeting));
                   System.debug(meeting.Name + ' is assigned to ' + associate);
               }
           }
        }
        System.debug('Finished testing getMeetings with participant');
        /**End getMeeting */
    }/**End getMeetingTest */
    


    /**Test getBatchTest ***************************************************************************/
   @isTest(seeAllData=true)
    public static void getBatchTest(){
        System.debug('Starting getBatchNames');
        List<String> names = MeetingAssignmentController.getBatchNames();
		RecordType RT = [SELECT Name FROM RecordType WHERE sObjectType='Account' AND Name=:'Batch'];
        List<Account> batchAccounts = [SELECT Name FROM Account WHERE RecordTypeID =:RT.Id ];
        for (Integer i=1; i<batchAccounts.size(); i++)
        {
            System.assertEquals(names[i], batchAccounts[i-1].Name);
            System.debug('Asserted match ' + i + ' successfully.');
        }
       System.debug('Finishing getBatchNames');
    }/**End getBatchTest */



     /**Test Setup **********************************************************************************/
   @isTest(seeAllData=true)
     public static void getAssociateTest(){
        System.debug('Testing getAssociates');  
         String batch = 'Batch 2';
         String testAgainst = 'Batch 1';
         Integer numberOfAssociates= [SELECT Count() FROM Contact WHERE Account.Name=:batch];
         List<String> associates = MeetingAssignmentController.getAssociates(batch);
         List<String> testAgainstAssociates = MeetingAssignmentController.getAssociates(testAgainst);
         List<Contact> associateProfiles = [SELECT Name, Account.Name FROM Contact WHERE Account.Name=:batch];
         System.assertEquals(numberOfAssociates, associates.size()-1);
         System.assertEquals('', associates[0]);
         System.assertNotEquals(associates, testAgainstAssociates);
         for (Integer i=1; i<associateProfiles.size(); i++)
         {
             System.assertEquals(batch, associateProfiles[i].Account.Name);
             System.assertEquals(associates[i], associateProfiles[i-1].Name);
             System.debug('Asserted match '+ i + ' successfully.');
         }
         System.debug('Finishing getAssociates');
       
    /**End getAssociates */
}
    }/**End getAssociate */