@isTest
private class SyncUtitlityTest {
    @TestSetup
    static void makeData(){
        syncUtilityClass SUC = new syncUtilityClass();
    }

    @isTest
    private static void testGetAssociates() {
        Account[] batch = new Account[]{};
        for(Integer i=0; i<5; i++) {
            batch.add(new Account(name='Test' + i, batchId__c='TR-123' + i) );
        }
        Test.setMock(HttpCalloutMock.class, new SyncCalloutMock());
        Test.startTest();
        

    }
    
}