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
    private static void testSetCroneExpression(){
        SyncCalloutMock scm = new SyncCalloutMock();
        Test.setMock(HttpCalloutMock.class, scm);

        Test.startTest();
        SyncController.setCRONExpression('0 0 0 ? * SUN *');
        Test.stopTest();

        CronTrigger existingJob = [SELECT Id, CronJobDetail.Name, CronExpression FROM CronTrigger WHERE CronJobDetail.JobType = '7' ORDER BY CreatedDate ASC LIMIT 1];
		
        System.assertEquals('Sync Caliber', existingJob.CronJobDetail.Name);
        System.assertEquals('0 0 0 ? * SUN *', existingJob.CronExpression);
    }

    @isTest 
    private static void testGetCRONExpression(){
        Test.startTest();
        SyncController.setCRONExpression('0 0 0 ? * SUN *');
        Test.stopTest();

        String[] expressionData = SyncController.getCRONExpression();
        System.debug(expressionData);
        System.assertEquals('24', expressionData[0]);
        System.assertEquals('00', expressionData[1]);
        System.assertEquals('SUN', expressionData[2]);
        System.assertEquals(UserInfo.getTimezone().getDisplayName(), expressionData[3]);
        System.assertEquals(4, expressionData.size());
    }
    
    @isTest 
    private static void testGetCRONExpressionNone(){

        String[] expressionData = SyncController.getCRONExpression();
        System.debug(expressionData);
        System.assertEquals('-1', expressionData[0]);
        System.assertEquals(1, expressionData.size());
    }
}