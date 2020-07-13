public class SyncController {

    @AuraEnabled
    public static void updateFromAura(){
        SyncUtilityClass util = new SyncUtilityClass();
        util.updateDatabase();
    }

    @testVisible
    private void createNewSchedule(String cronTime) {
        try {
            CronTrigger existingJob = [SELECT Id, CronJobDetail.Id, CronJobDetail.Name FROM CronTrigger WHERE CronJobDetail.JobType = '7' ORDER BY CreatedDate ASC LIMIT 1];
            System.abortJob(existingJob.Id);
        } catch (exception e) {
            System.debug('No existing job found');
        }

        SyncSchedule schedule = new SyncSchedule();
        String jobId = System.schedule('Sync Caliber', cronTime, schedule);
        Setting__c defaultCRON;

        try {
            defaultCRON = [SELECT Id FROM Setting__c WHERE Name = 'Current CRON'];
        } catch(exception e) {
            defaultCRON = new Setting__c(Name='Current CRON',
                                         Expression__c = '0 0 0 ? * SUN *' );
            insert defaultCRON;
        }

        defaultCRON.JobId__c = jobId;
        update defaultCRON;
    }

    @AuraEnabled
    public static void setCRONExpression(String newCRON){
        try{
            Setting__c currentCron = [SELECT Name, Expression__c FROM Setting__c WHERE Name = 'Current CRON'];
            currentCRON.Expression__c = newCRON;
            update currentCRON;
        }
        catch(exception e){
            Setting__c thisCron = new Setting__c(name='Current CRON', Expression__C=newCRON);
            insert thisCron;
        }
        finally{
            SyncController instance = new SyncController();
            instance.createNewSchedule(newCRON);
        }
        
    }

    @AuraEnabled
    public static String[] getCRONExpression(){ 
        
        try{
            Setting__c currentCron = [SELECT Name, Expression__c FROM Setting__c WHERE Name = 'Current CRON'];
            String[] getValues = currentCRON.Expression__c.split(' ');
            getValues.remove(6);
            getValues.remove(4);
            getValues.remove(3);
            getValues.remove(0);
            
            return getValues;
        }
        catch(exception e){
            List<String> x = new List<String>();
            x.add('-1');
            return x;
        }
        
    }
}