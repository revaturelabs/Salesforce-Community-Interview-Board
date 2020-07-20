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
        Profile prof = [SELECT id FROM Profile WHERE Name = 'Associate'];
        
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
        
        Id recordTypeId = Schema.SObjectType.Meeting__c.getRecordTypeInfosByName().get('Mock Interview').getRecordTypeId();
            
        Meeting__c newMeet = new Meeting__c(Name = 'TestMeeting', Meeting_Status__c = 'Mock', RecordTypeId=recordTypeId);
        
        
        Database.SaveResult savedMeeting = Database.insert(newMeet);
        
        Id meetId = savedMeeting.getId();
        
        
        Meeting_Participant__c mP = new Meeting_Participant__c(Name='LOLOLOL', Participant__c=conta.Id, Meeting__c= meetId);
        
        insert mP;
        
        System.runAs(testUser) {
            
            
            
            List<Meeting__c> returnedList = MockInterviewsListController.getInterviews();

            
            
            system.assertEquals(1, returnedList.size());
            
            
        }
    }
    
}