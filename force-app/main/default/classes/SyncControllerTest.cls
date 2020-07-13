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

    @isTest 
    private static void testSetCroneExpression(){
        SyncCalloutMock scm = new SyncCalloutMock();
        Test.setMock(HttpCalloutMock.class, scm);

        Test.startTest();
        SyncController.setCRONExpression('0 0 0 1 1 ? *');
        Test.stopTest();

        Setting__c[] settings = [SELECT Name, Expression__c FROM Setting__c];

        System.assertEquals(1, settings.size());
        System.assertEquals('Current CRON', settings[0].Name);
        System.assertEquals('0 0 0 1 1 ? *', settings[0].Expression__c);
    }

    @isTest 
    private static void testGetCRONExpression(){
        Test.startTest();
        String[] ex = SyncController.getCRONExpression();
        Setting__c currentCron = new Setting__c(Name='Current CRON', Expression__c='0 0 0 1 1 ? *');
        insert currentCron;
        ex.addAll(SyncController.getCRONExpression());
        Test.stopTest();

        System.assertEquals('-1', ex[0]);
        System.assertEquals('0', ex[1]);
        System.assertEquals('0', ex[2]);
        System.assertEquals('?', ex[3]);
        System.assertEquals(4, ex.size());
    }
}
