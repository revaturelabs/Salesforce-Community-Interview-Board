@isTest
private class SyncControllerTest {
    @isTest
    private static void testUpdateFromAura() {
        SyncCalloutMock scm = new SyncCalloutMock();
        Test.setMock(HttpCalloutMock.class, scm);

        Test.startTest();
        SyncController.updateFromAura();
        Test.stopTest();

        Account[] internalBatches = [SELECT BatchId__c FROM Account WHERE recordType.Name IN ('Batch')];

        System.assertEquals(2, internalBatches.size());
    }

    @isTest 
    private static void testCreateNewSchedule(){
        SyncController sc = new SyncController();
        SyncCalloutMock scm = new SyncCalloutMock();
        Test.setMock(HttpCalloutMock.class, scm);

        Test.startTest();
        sc.createNewSchedule('0 0 0 1 1 ? *');
        Test.stopTest();

        List<CronTrigger> existingJobs = [SELECT Id FROM CronTrigger];
        System.assertEquals(1, existingJobs.size());
    }
}
