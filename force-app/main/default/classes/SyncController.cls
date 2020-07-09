public class SyncController {
    
    static {
        Setting__c[] currentCron = [SELECT Name, Expression__c FROM Setting__c WHERE Name = 'Current CRON'];
        if(currentCRON.size() == 0) {
            SyncSchedule schedule = new SyncSchedule();
            String jobId = System.schedule('Sync Caliber', '0 0 0 ? * SUN *', schedule);
            Setting__c defaultCRON = new Setting__c(Name = 'Current CRON',
                                                    Expression__c = '0 0 0 ? * SUN *',
                                                    JobId__c = jobId);
        }
    }

    @AuraEnabled
    public static void updateFromAura(){
        SyncUtilityClass util = new SyncUtilityClass();
        util.updateDatabase();
    }

    private void createNewSchedule(String cronTime) {
        CronTrigger existingJob = [SELECT Id, CronJobDetail.Id, CronJobDetail.Name FROM CronTrigger WHERE CronJobDetail.JobType = '7' ORDER BY CreatedDate ASC LIMIT 1];
        System.abortJob(existingJob.Id);
        SyncSchedule schedule = new SyncSchedule();
        String jobId = System.schedule('Sync Caliber', cronTime, schedule);
        Setting__c defaultCRON = new Setting__c(Name = 'Current CRON',
                                                Expression__c = cronTime,
                                                JobId__c = jobId);
    }

    @AuraEnabled
    public static void setCRONExpression(String newCRON){
        Setting__c currentCron = [SELECT Name, Expression__c FROM Setting__c WHERE Name = 'Current CRON'];
        currentCRON.Expression__c = newCRON;
        update currentCRON;
        SyncController instance = new SyncController();
        instance.createNewSchedule(newCRON);
    }

    @AuraEnabled
    public static String[] getCRONExpression(){
        Setting__c currentCron = [SELECT Name, Expression__c FROM Setting__c WHERE Name = 'Current CRON'];
        String[] getValues = currentCRON.Expression__c.split(' ');
        getValues.remove(6);
        getValues.remove(4);
        getValues.remove(3);
        getValues.remove(0);
        return getValues;
    }
}
