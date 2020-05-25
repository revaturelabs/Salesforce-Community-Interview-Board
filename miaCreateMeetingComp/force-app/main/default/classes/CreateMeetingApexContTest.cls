@isTest
public with sharing class CreateMeetingApexContTest {

    @TestSetup
    static void makeData(){

        //Query record types (SeeAllData not necessary) to assign to test data
        RecordType batch = [SELECT Id FROM RecordType WHERE Name='Batch'];
        RecordType associate = [SELECT Id FROM RecordType WHERE Name='Associate'];
        RecordType client = [SELECT Id FROM RecordType WHERE Name='Client' LIMIT 1];

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
            testAssociates.add(new Contact(Firstname='AB1', LastName = String.valueOf(i), AccountId=testBatches[0].Id,
            RecordTypeId=associate.Id));
        for(Integer i=5; i<9; i++)
            testAssociates.add(new Contact(Firstname='AB2', LastName = String.valueOf(i), AccountId=testBatches[1].Id,
            RecordTypeId=associate.Id));
        
        //Create 2 Client Contacts with appropriate record type
        Account interviewer = new Account(Name='Steampunk');
        insert interviewer;
        for(Integer i=0; i<2; i++)
            testClients.add(new Contact(FirstName='Int', LastName = String.valueOf(i), AccountId=interviewer.Id, RecordTypeId=client.Id));
        

        //Insert all data
        insert testAssociates;
        insert testClients;
        
    }

    // This method would test all other "get" methods as it calls them within itself
    @isTest
    public static void getAllTest()
    {
        List<List<sObject>> all = new List<List<sObject>>();
        Integer cliCount = Integer.valueOf([SELECT COUNT() FROM Contact WHERE RecordType.Name = 'Client']);
        Integer ascCount = Integer.valueOf([SELECT COUNT() FROM Contact WHERE RecordType.Name = 'Associate']);
        Integer batCount = Integer.valueOf([SELECT COUNT() FROM Account WHERE RecordType.Name = 'Batch']);

        all = CreateMeetingApexCont.getAll();

        System.assertEquals(3, all.size());
        System.assertEquals(cliCount, all.get(0).size());
        System.assertEquals(ascCount, all.get(1).size());
        System.assertEquals(batCount, all.get(2).size());
    }

    @isTest
    public static void createMeetingTest()
    {
        String strCli = String.valueOf([SELECT Id FROM Contact WHERE RecordType.Name = 'Client' LIMIT 1].Id);
        String strAsc = String.valueOf([SELECT Id FROM Contact WHERE RecordType.Name = 'Associate' LIMIT 1].Id);

        Meeting__c meet = new Meeting__c(Name='Test');
        Meeting__c result = CreateMeetingApexCont.createMeeting(meet, strCli, strAsc);

        System.assertEquals(meet, result);

        Integer partCount = Integer.valueOf([SELECT COUNT() FROM Meeting_Participant__c WHERE Meeting__c =: result.Id]);

        System.assertEquals(2, partCount);
    }

    @isTest
    public static void createMeetingAllBatchTest()
    {
        String strCli = String.valueOf([SELECT Id FROM Contact WHERE RecordType.Name = 'Client' LIMIT 1].Id);
        Account batch = [SELECT Id FROM Account WHERE RecordType.Name = 'Batch' LIMIT 1];
        List<Contact> ascList = [SELECT Id FROM Contact WHERE AccountId =: batch.Id];

        Meeting__c meet = new Meeting__c(Name='Test');
        Meeting__c result = CreateMeetingApexCont.createMeetingAllBatch(meet, strCli, ascList);

        System.assertEquals(meet, result);

        Integer partCount = Integer.valueOf([SELECT COUNT() FROM Meeting_Participant__c WHERE Meeting__c =: result.Id]);

        System.assertEquals(ascList.size()+1, partCount);
    }
}
