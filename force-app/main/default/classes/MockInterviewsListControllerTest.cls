@isTest
public class MockInterviewsListControllerTest {
    
    @testSetup
    static void makeUser(){
        
        Account testAcc = new Account();
        testAcc.name = 'test company';
        Database.SaveResult savedAccount = Database.insert(testAcc);
        Id accID = savedAccount.getId();
        
        
        Contact con = new Contact(lastname = 'stuff', AccountId = accId);
        Database.SaveResult savedContact = Database.insert(con);
        

        
        Id contId = savedContact.getId();
        Profile prof = [SELECT id FROM Profile WHERE Name = 'Customer Community User BUT WAY BETTER'];
        
        User u = new User(firstName = 'test1', lastName ='stuff', profileId = prof.id, 
                          username = 'test@test.com', email = 'test@test.com', ContactId = contId,
                          alias= 'Test', TimeZoneSidKey='America/New_York', LocaleSidKey='en_US',
                          EmailEncodingKey='ISO-8859-1', LanguageLocaleKey='en_US', IsActive = true);
        insert u;
        
        
        
    }
    
    @isTest
    public static void MockInterviewsListControllerTest() {
        User testUser = [SELECT id FROM User WHERE lastName='stuff']; 
        
        Contact conta = [SELECT id FROM Contact WHERE lastname='stuff'];
            
        Meeting__c newMeet = new Meeting__c(Name = 'TestMeeting', Meeting_Status__c = 'Mock');
        
        
        Database.SaveResult savedMeeting = Database.insert(newMeet);
        
        Id meetId = savedMeeting.getId();
        
        
        Meeting_Participant__c mP = new Meeting_Participant__c(Name='LOLOLOL', Participant__c=conta.Id, Meeting__c= meetId);
        
        insert mP;
        
        System.runAs(testUser) {
            
            
            
            List<Meeting__c> wtfman = MockInterviewsListController.getInterviews();

            
            
            system.assertEquals(1, wtfman.size());
            
            
        }
    }
    
}



        /*
        User aY = new User(firstname = 'otherTestUser2', lastName ='otherTestUser2', profileId = prof.id,
                          username = 'otherTestUser@testuser.com', email ='otherTestUser@testuser.com', ContactId = otherCon.id,
                          alias='otherTest', TimeZoneSidKey='America/New_York', LocaleSidKey='en_US',
                          EmailEncodingKey='ISO-8859-1', LanguageLocaleKey='en_Us', IsActive = true);
        
        insert aY;
        

        List<Meeting__c> testMeetingList = new List<Meeting__c>();
        
        //Meeting__c andyMeeting = new Meeting__c();

        /*
        andyMeeting.name('aYMeeting');
        andyMeeting.Meeting_Status__c('Mock');
        andyMeeting.CreatedById(aY.Id);
        testMeetingList.add(andyMeeting);

        Meeting__c uMeeting = new Meeting__c();

        uMeeting.name('uMeeting');
        uMeeting.Meeting_Status__c('Mock');
        uMeeting.CreatedById(u.Id);
        testMeetingList.add(uMeeting);
        
        //testMeetingList.add(new Meeting__c(Name = 'Test Mock Interview ' + ('u'), RecordTypeId ='0123h0000006OXmAAM', ));
        testMeetingList.add(new Meeting__c(Name = 'Test Mock Interview ' + ('aY'), RecordTypeId ='0123h0000006OXmAAM' ));

        insert testMeetingList;
        
*/