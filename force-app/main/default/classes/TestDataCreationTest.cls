@isTest
public with sharing class TestDataCreationTest {
    
    @isTest
    public static void resetTest()
    {
        Test.startTest();
        TestDataCreation.reset();
        Test.stopTest();

        List<List<sObject>> objs = new List<List<sObject>>();
        objs.add([SELECT Id, (SELECT Id FROM Contacts), Account.RecordType.Name FROM Account]);
        objs.add([SELECT Id FROM Batch_Client__c]);
        objs.add([SELECT Id FROM Meeting__c]);
        objs.add([SELECT Id FROM Meeting_Participant__c]);
        objs.add([SELECT Id FROM Interview_Question__c]);

        System.assertEquals(15, objs.get(0).size());
        for(Account a : (List<Account>)objs.get(0))
        {
            if(a.RecordType.Name == 'Client')
            {
                System.assert(1 <= a.Contacts.size());
                System.assert(3 >= a.Contacts.size());
            }
            else
            {
                System.assert(10 <= a.Contacts.size());
                System.assert(20 >= a.Contacts.size());
            }
        }

    }
}
