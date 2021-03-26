public class SyncController {
    
    @AuraEnabled
    public static List<Integer> updateFromAura(){
        List<Integer> updateCounts = new List<Integer>();
        
        SyncUtilityClass util = new SyncUtilityClass();
        updateCounts = util.updateDatabase();
        
        return updateCounts;
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
            CronTrigger cronInfoRecord = [SELECT NextFireTime FROM CronTrigger WHERE CronJobDetail.Name='Sync Caliber' LIMIT 1];
            String cronInfo = cronInfoRecord.NextFireTime.format('kk-mm-EEE').toUpperCase();
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