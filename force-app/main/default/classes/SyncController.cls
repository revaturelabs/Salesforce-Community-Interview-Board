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
    public static String setCRONExpression(String newCRON){
        String[] getValues = newCRON.split(' ');
        DateTime today = DateTime.now();
        DateTime toStore = DateTime.newInstance(today.year(), today.month(), today.day(), integer.valueof(getValues.get(2)), integer.valueof(getValues.get(1)), 0);
        String tz = UserInfo.getTimeZone().getDisplayName();
        try{
            Setting__c currentCron = [SELECT Name, Expression__c, SetDate__c, Weekday__c FROM Setting__c WHERE Name = 'Current CRON'];
            currentCRON.Expression__c = newCRON;
            currentCRON.SetDate__c = toStore;
            currentCron.Weekday__c = getValues.get(5);
            update currentCRON;
        }
        catch(exception e){
            Setting__c thisCron = new Setting__c(name='Current CRON',
                                                 Expression__C=newCRON,
                                                 SetDate__c=toStore,
                                                 Weekday__c=getValues.get(5));
            insert thisCron;
        }
        finally{
            SyncController instance = new SyncController();
            instance.createNewSchedule(newCRON);
        }
        return tz;
    }
    
    private Integer getIndex(String day) {
        Map<String,Integer> dayToIndex = new Map<String,Integer>{
            'SUN' => 1,
                'MON' => 2,
                'TUE' => 3,
                'WED' => 4,
                'THU' => 5,
                'FRI' => 6,
                'SAT' => 7
                };
                    
                    return dayToIndex.get(day);
    }
    
    private String getWeekday(Integer day) {
        Map<Integer,String> dayToIndex = new Map<Integer,String>{
            1 => 'SUN',
                2 => 'MON',
                3 => 'TUE',
                4 => 'WED',
                5 => 'THU',
                6 => 'FRI',
                7 => 'SAT'
                };
                    
                    return dayToIndex.get(day);
    }
    
    @AuraEnabled
    public static String[] getCRONExpression(){ 
        SyncController sc = new SyncController();
        String tz = UserInfo.getTimeZone().getDisplayName();
        try{
            Setting__c currentCron = [SELECT Name, Expression__c, SetDate__c, Weekday__c FROM Setting__c WHERE Name = 'Current CRON'];
            Integer dayForUser = Integer.valueof(currentCRON.SetDate__c.format('dd'));
            System.debug(dayForUser);
            DateTime dateData = currentCron.SetDate__c;
            System.debug(dateData.day());
            String weekday = currentCron.Weekday__c;
            if( dateData.day() > dayForUser) {
                weekday = sc.getWeekday(sc.getIndex(weekday) - 1);
            } else if ( dateData.day() < dayForUser ) {
                weekday = sc.getWeekday(sc.getIndex(weekday) + 1);
            }
            String userDisplay = dateData.format('mm-kk');
            String[] values = userDisplay.split('-');
            values.add(weekday);
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