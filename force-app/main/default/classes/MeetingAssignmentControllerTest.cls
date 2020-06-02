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
        Account testBatch = [SELECT Name FROM Account WHERE RecordType.Name ='Batch' LIMIT 1];
        Contact testAssociates = [SELECT Name FROM Contact WHERE Account.Name = :testBatch.Name LIMIT 1];
        List<Meeting__c> meetingsByBatch=  MeetingAssignmentController.getMeetings(testBatch.Name, '');
        System.debug(meetingsByBatch);
        RecordType RT = [SELECT Name, Id FROM RecordType WHERE sObjectType='Meeting__c' AND Name='Interview Batch'];
        RecordType RT2 = [SELECT Name, Id FROM RecordType WHERE sObjectType='Meeting__c' AND Name='Intervention Batch'];
       Boolean test;
        for (Meeting__c meeting: meetingsByBatch)
        {            
			if (meeting.RecordTypeId==RT.Id | meeting.RecordTypeId==RT2.Id)
            {
                System.debug(meeting);
               
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
       
		List<Meeting__c> meetingsByAssociate = MeetingAssignmentController.getMeetings(testBatch.Name, testAssociates.Name);
        System.debug(meetingsByAssociate);
        List<Meeting__c> testList = [SELECT Name, (SELECT Participant__r.Name FROM Meeting_Participants__r) FROM Meeting__c];
        for (Meeting__c meeting: testList)
        {
           for(Meeting_Participant__c participant : meeting.Meeting_Participants__r)
           {
               if (participant.Participant__r.Name == testAssociates.Name)
               {
               System.assert(true, meetingsByAssociate.contains(meeting));
                   System.debug(meeting.Name + ' is assigned to ' + testAssociates.Name);
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
         List<Account> batches = new List<Account>([SELECT Name FROM Account WHERE RecordType.Name ='Batch']);
         
         Integer numberOfAssociates= [SELECT Count() FROM Contact WHERE Account.Name=:batches[0].Name];
         List<String> associates = MeetingAssignmentController.getAssociates(batches[0].Name);
         List<String> testAgainstAssociates = MeetingAssignmentController.getAssociates(batches[1].Name);
         List<Contact> associateProfiles = [SELECT Name, Account.Name FROM Contact WHERE Account.Name=:batches[0].Name];
         System.assertEquals(numberOfAssociates, associates.size()-1);
         System.assertEquals('', associates[0]);
         System.assertNotEquals(associates, testAgainstAssociates);
         for (Integer i=1; i<associateProfiles.size(); i++)
         {
             System.assertEquals(batches[0].Name, associateProfiles[i].Account.Name);
             System.assertEquals(associates[i], associateProfiles[i-1].Name);
             System.debug('Asserted match '+ i + ' successfully.');
         }
         System.debug('Finishing getAssociates');
       
    /**End getAssociates */
}
    }/**End getAssociate */