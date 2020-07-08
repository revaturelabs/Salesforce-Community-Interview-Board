@isTest
private class SyncUtitlityTest {
    @TestSetup
    static void makeData(){
        Account[] batches = new Account[]{};
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Batch').getRecordTypeId();
        for(Integer i=0; i<5; i++) {
            batches.add(new Account(name='Test' + i, batchId__c='TR-123' + i, recordTypeId=recordTypeId) );
        }
        insert batches;
    }

    @isTest
    private static void testGetAssociates() {
        syncUtilityClass SUC = new syncUtilityClass();
        Test.setMock(HttpCalloutMock.class, new SyncCalloutMock());
        
        Test.startTest();
        Contact[] contacts = SUC.getAssociates();
        Test.stopTest();
        
        //System.debug( 'size: '+ contacts.size() + 'contacts: ' + contacts );
        System.assertEquals(10, contacts.size());
    }
    
    @isTest
    private static void testGetBatches() {
        syncUtilityClass SUC = new syncUtilityClass();
        Test.setMock(HttpCalloutMock.class, new SyncCalloutMock());

        Test.startTest();
        Account[] accounts = SUC.getBatches();
        Test.stopTest();

        System.assertEquals(2, accounts.size());
    }
}