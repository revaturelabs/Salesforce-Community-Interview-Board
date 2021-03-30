@isTest
public with sharing class CreateMeetingApexContTest {

    static void makeBatches(Integer cnt)
    {
        List<Account> batches = new List<Account>();
        RecordType batch = [SELECT Id FROM RecordType WHERE Name = 'Batch' LIMIT 1];

        for(integer i = 0; i < cnt; i++)
            batches.add(new Account(Name='Batch ' + i, RecordTypeId = batch.Id));

        insert batches;
    }

    static void makeAssociates(integer batCnt, integer ascCnt)
    {
        makeBatches(batCnt);
        List<Account> batches = [SELECT Id FROM Account WHERE RecordType.Name = 'Batch'];

        List<Contact> associates = new List<Contact>();
        RecordType associate = [SELECT Id FROM RecordType WHERE Name = 'Associate' LIMIT 1];

        for(integer i = 0; i < batCnt; i++)
        {
            for(integer j = 0; j < ascCnt; j++)
            {
                associates.add(new Contact(FirstName = 'Bat' + i,
                                           LastName = 'Asc' + j,
                                           RecordTypeId = associate.Id,
                                           AccountId = batches.get(i).Id));
            }
        }

        insert associates;
    }

    static void makeClients(integer cnt)
    {
        List<Contact> cliCon = new List<Contact>();

        List<RecordType> rt = [SELECT Id, Name FROM RecordType WHERE Name = 'Client'];
        integer ind = 1;
        Account cliAcc = new Account(Name = 'Client Account');
        try {
            cliAcc.RecordTypeId = rt.get(0).Id;
            insert cliAcc;
        } catch(Exception e) {
            cliAcc.RecordTypeId = rt.get(1).Id;
            insert cliAcc;
            ind = 0;
        }
        rt = [SELECT Id, Name FROM RecordType WHERE Name = 'Client'];
        System.debug(rt);
        for(integer i = 0; i < cnt; i++)
        {
            Contact c = new Contact(LastName = 'Client ' + i, AccountId = cliAcc.Id);
            c.RecordTypeId = rt.get(ind).Id;
            cliCon.add(c);
        }

        insert cliCon;
    }

    @isTest
    public static void getAllTestNull()
    {
        List<List<sObject>> all = CreateMeetingApexCont.getAll();

        System.assertEquals(3, all.size());
        System.assertEquals(0, all.get(0).size());
        System.assertEquals(0, all.get(1).size());
        System.assertEquals(0, all.get(2).size());
    }

    // This method would test all other "get" methods as it calls them within itself
    @isTest
    public static void getAllTest()
    {
        makeClients(10);
        makeAssociates(10, 10);

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
        makeClients(1);
        makeAssociates(1,1);
        
        String strAsc = String.valueOf([SELECT Id FROM Contact WHERE RecordType.Name = 'Associate' LIMIT 1].Id);
        String strCli = String.valueOf([SELECT Id FROM Contact WHERE RecordType.Name = 'Client' LIMIT 1].Id);

        Meeting__c meet = new Meeting__c(Name='Test');
        Meeting__c result = CreateMeetingApexCont.createMeeting(meet, strCli, strAsc);

        System.assertEquals(meet, result);

        Integer partCount = Integer.valueOf([SELECT COUNT() FROM Meeting_Participant__c WHERE Meeting__c =: result.Id]);

        System.assertEquals(2, partCount);
    }

    @isTest
    public static void createMeetingAllBatchTest()
    {
        makeClients(1);
        makeAssociates(1, 10);

        String strCli = String.valueOf([SELECT Id FROM Contact WHERE RecordType.Name = 'Client'].Id);
        Account batch = [SELECT Id FROM Account WHERE RecordType.Name = 'Batch' LIMIT 1];
        List<Contact> ascList = [SELECT Id FROM Contact WHERE AccountId =: batch.Id];

        Meeting__c meet = new Meeting__c(Name='Test');
        Meeting__c result = CreateMeetingApexCont.createMeetingAllBatch(meet, strCli, ascList);

        System.assertEquals(meet, result);

        Integer partCount = Integer.valueOf([SELECT COUNT() FROM Meeting_Participant__c WHERE Meeting__c =: result.Id]);

        System.assertEquals(ascList.size()+1, partCount);
    }

    @isTest
    public static void createMeetingNullTest()
    {
        makeClients(1);
        makeAssociates(1,10);

        Contact client = [SELECT Id FROM Contact WHERE RecordType.Name = 'Client' LIMIT 1];
        Contact associate = [SELECT Id FROM Contact WHERE RecordType.Name = 'Associate' LIMIT 1];

        String strCli = String.valueOf(client.Id);
        String strAsc = String.valueOf(associate.Id);

        Meeting__c m1 = CreateMeetingApexCont.createMeeting(new Meeting__c(), strCli, strAsc),
                   m2 = CreateMeetingApexCont.createMeeting(new Meeting__c(Name = 'Meeting 2'), '', strAsc),
                   m3 = CreateMeetingApexCont.createMeeting(new Meeting__c(Name = 'Meeting 2'), strCli, '');

        System.assertEquals(null, m1);
        System.assertEquals(null, m2);
        System.assertEquals(null, m3);
    }

    @isTest
    public static void createMeetingAllBatchNullTest()
    {
        makeClients(1);
        makeAssociates(1,10);

        Contact client = [SELECT Id FROM Contact WHERE RecordType.Name = 'Client' LIMIT 1];
        List<Contact> associates = [SELECT Id FROM Contact WHERE RecordType.Name = 'Associate'];

        String strCli = String.valueOf(client.Id);

        Meeting__c m1 = CreateMeetingApexCont.createMeetingAllBatch(new Meeting__c(), strCli, associates),
                   m2 = CreateMeetingApexCont.createMeetingAllBatch(new Meeting__c(Name = 'Meeting 2'), '', associates),
                   m3 = CreateMeetingApexCont.createMeetingAllBatch(new Meeting__c(Name = 'Meeting 2'), strCli, new List<Contact>());

        System.assertEquals(null, m1);
        System.assertEquals(null, m2);
        System.assertEquals(null, m3);
    }
}

/*@TestSetup
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
        
    }*/