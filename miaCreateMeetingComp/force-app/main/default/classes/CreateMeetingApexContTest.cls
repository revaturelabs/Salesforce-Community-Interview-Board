@isTest
public with sharing class CreateMeetingApexContTest {
    public CreateMeetingApexContTest() {}

        @TestSetup
        static void makeData(){

            //Query record types (SeeAllData not necessary) to assign to test data
            RecordType batch = [select Id from RecordType where Name='Batch'];
            RecordType associate = [select Id from RecordType where Name='Associate'];
            RecordType client = [select Id from RecordType where Name='Client'];

            //Instantiate Lists for data to be queried
            List<Account> testBatches = new List<Account>();
            List<Contact> testAssociates = new List<Contact>();
            List<Contact> testClients = new List<Contact>();
            
            //Create and insert Batches so we can create Associates to assign to them
            for(Integer i=0; i<2; i++)
                testBatches.add(new Account(Name='Batch '+i, RecordTypeId=batch.Id));
                                   
            insert testBatches;


            //Create 5 Associates for the first batch, 4 for the second batch
            for(Integer i=0; i<5; i++)
                testAssociates.add(new Contact(Firstname='Associate '+i, AccountId=testBatches[0].Id,
                RecordTypeId=associate.Id));
            for(Integer i=5; i<9; i++)
                testAssociates.add(new Contact(Firstname='Associate '+i, AccountId=testBatches[1].Id,
                RecordTypeId=associate.Id));
            
            //Create 2 Client Contacts with appropriate record type
            Account interviewer = new Account(Name='Steampunk');
            insert interviewer;
            for(Integer i=0; i<2; i++)
                testClients.add(new Contact(FirstName='Interviewer '+i, AccountId=interviewer.Id, RecordTypeId=client.Id));
           

            //Insert all data
            insert testAssociates;
            insert testClients;
            
        }

    
}
