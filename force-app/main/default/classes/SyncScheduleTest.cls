@isTest
private class SyncScheduleTest {
    @isTest
    private static void testScheduledJob() {
        SyncSchedule ss = new SyncSchedule();
        Test.setMock(HttpCalloutMock.class, new SyncCalloutMock());
        String CRON_EXP = '0 0 0 1 1 ? *';

        Test.startTest();
        Id TestId = System.schedule('jobName', CRON_EXP, ss);
        Test.stopTest();

        List<CronTrigger> existingJobs = [SELECT Id, CronJobDetail.Id, CronJobDetail.Name FROM CronTrigger WHERE CronJobDetail.JobType = '7'];
        System.assertEquals(1, existingJobs.size());
    }
}