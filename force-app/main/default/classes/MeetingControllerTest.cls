@isTest
public class MeetingControllerTest {

   // Performs a restricted user test for the MeetingController method 'getProfilePerm' for a user that has the 'System Administrator' Profile -> Test succeeds when assertion comes back true
 	 @isTest
    public static void getAdminProfilePermTest(){
        
        String uName = 'user' + Datetime.now().getTime() + '@whateverjoe123.com';
        Profile p = [SELECT id FROM Profile WHERE name='System Administrator'];
        User u = new User(alias = 'testUser', email='testuser@whateverjoe123.com', emailencodingkey='UTF-8', lastname = 'Test', languagelocalekey='en_us',
                         timezonesidkey='america/new_york', localeSidKey='en_us', profileId=p.id, username=uName);
        insert u;
        System.runAs(u){
            system.debug(UserInfo.getProfileId());
            MeetingController.getProfilePerm();
            system.assertEquals(true, MeetingController.getProfilePerm());
        }
        
    } 
    
    // Performs a restricted user test for the MeetingController method 'getProfilePerm' for a user that has the 'Associate' Profile -> Test succeeds when assertion comes back false
    @isTest
    public static void getAssociateProfilePermTest(){
         Set<String> customerUserType = new Set<String> {'Associate'};
		Account acc = new Account (
		Name = 'newAcc1'
		);  
		insert acc;
		Contact con = new Contact (
		AccountId = acc.id,
		LastName = 'portalTestUser'
		);
		insert con;
        
		id customerP = [select Id from Profile where name = 'Associate'].id;
 
		User newUser = new User(
		profileId = customerP,
		username = 'customerusertest@whateverjoe123.com',
		email = 'custtestuser@whatever.com',
		emailencodingkey = 'UTF-8',
		localesidkey = 'en_US',
		languagelocalekey = 'en_US',
		timezonesidkey = 'America/new_york',
		alias='nuser',
		lastname='lastname',
		contactId = con.id
		);
		insert newUser;
        
        system.runAs(newUser){
               system.debug(UserInfo.getProfileId());
            	MeetingController.getProfilePerm();
            	system.assertEquals(false, MeetingController.getProfilePerm());

        }
    }
    
    //Performs a mock callout test for the MeetingController method 'createEvent' 
    @isTest
    public static void createEventsTest(){  
		Test.setMock(HttpCalloutMock.class, new createEventMock());
        
        String testIntName = 'Bob Bobson';
        id testId = 'a034W00000VJCbnQAH';
        String testName = 'Test Event';
        DateTime startTime = DateTime.newInstance(2020, 08, 30, 00, 30, 00);
        DateTime endTime = DateTime.newInstance(2020, 08, 30, 00, 30, 00);
        
        MeetingController.createEvent(testIntName, testId, testName, startTime, endTime);
        
    }
    
    
    //Test method for the MeetingController method 'createTimeslots' where the assertion returns true if the integer returns as a value equal to 1
    @isTest
    public static void createTimeSlotsTest(){
          String intName = 'Bob Bobson';
        
         Integer testNumTimeSlots = MeetingController.createTimeslots(intName, DateTime.now(),DateTime.now().addHours(1), 'Salesforce');
        
         system.assertEquals(testNumTimeSlots, 1);
        
    }
    
    
    //Test method for MeetingController method 'getActiveStacks' that implements the MeetingControllerTestUtility class for a datafactory 
	// -> assertion returns true if the list contains either 'Java', '.NET', or 'SalesForce
    @isTest
    public static void getActiveStacksTest(){
        MeetingControllerTestUtility.createScheduledMeetings(100);
        
        List<String> stackList = MeetingController.getActiveStacks();
            
        system.assert(stackList.contains('Java'));
        system.assert(stackList.contains('.NET'));
        system.assert(stackList.contains('Salesforce'));

    }
    
    
    //Mock callout test method for MeetingController method 'getEvent' where assertion returns true when the expectedResult and result are both equal to the hangoutLink
    //Implements (SeeAllData=True) in order to get recordId from database as it is a necessary parameter to perform 'getEvent' method
    @isTest(SeeAllData=True)
    public static void getEventTest(){
        
        Test.setMock(HttpCalloutMock.class, new getEventMock());
        
        String result = MeetingController.getEvent('a063t00000bzxYjAAI');
        system.debug(result);
        String expectedResult = 'https://meet.google.com/gti-ecrv-ahg';
        System.assertEquals(expectedResult, result);
    }
   
}