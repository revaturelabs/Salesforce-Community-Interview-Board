public class SyncController {
    
    @AuraEnabled
    public static void updateFromAura(){
        SyncUtilityClass util = new SyncUtilityClass();
        util.updateDatabase();
    }
    
    @AuraEnabled
    public static void setCRONExpression(String newCRON){
        try {
            CronTrigger existingJob = [SELECT Id, CronJobDetail.Id, CronJobDetail.Name FROM CronTrigger WHERE CronJobDetail.JobType = '7' ORDER BY CreatedDate ASC LIMIT 1];
            System.abortJob(existingJob.Id);
        } catch (exception e) {
            System.debug('No existing job found');
        }
        
        SyncSchedule schedule = new SyncSchedule();
        String jobId = System.schedule('Sync Caliber', newCron, schedule);
    }
    
    @AuraEnabled
    public static String[] getCRONExpression(){
        String tz = UserInfo.getTimeZone().getDisplayName();
        try{
            CronTrigger cronInfoRecord = [SELECT NextFireTime FROM CronTrigger];
            String cronInfo = cronInfoRecord.NextFireTime.format('hh-mm-EEE').toUpperCase();
            String[] values = cronInfo.split('-');
            values.add(tz);
            
            return values;
        }
        catch(exception e){
            List<String> x = new List<String>();
            x.add('-1');
            return x;
        }
        
    }
}