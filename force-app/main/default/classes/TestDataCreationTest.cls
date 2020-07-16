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
        //objs.add([SELECT Id, (SELECT Id FROM Meeting_Participants__r), (SELECT Id FROM Interview_Questions__r), RecordType.Name FROM Meeting__c]);

        Map<Id, List<Contact>> batMap = new Map<Id, List<contact>>();

        System.assertEquals(15, objs.get(0).size());
        for(Account a : (List<Account>)objs.get(0))
        {
            batMap.put(a.Id, a.Contacts);
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
        System.assert(15 <= objs.get(1).size());
        System.assert(19 >= objs.get(1).size());

        System.assert(60 <= objs.get(2).size());
        System.assert(120 >= objs.get(2).size());

        for(Meeting__c m : (List<Meeting__c>)objs.get(2))
        {
            if(m.RecordType.Name == 'Invertention 1-1' || m.RecordType.Name == 'Interview 1-1')
                System.assert(2 == m.Meeting_Participants__r.size());
            else
            {
                System.assert(2 <= m.Meeting_Participants__r.size());
                System.assertEquals(batMap.get(m.Batch__c).size()+1, m.Meeting_Participants__r.size());
            }

            //System.assert(5 <= m.Interview_Questions__r.size());
            //System.assert(20 >= m.Interview_Questions__r.size());
        }

    }
}