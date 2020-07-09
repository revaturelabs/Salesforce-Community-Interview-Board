public class SyncController {
    
    static {
        SyncSchedule schedule = new SyncSchedule();
        String initialCron = '';

    }

    @AuraEnabled
    public static void updateFromAura(){
        SyncUtilityClass util = new SyncUtilityClass();
        util.updateDatabase();
    }

    private static String CRON = '0 0 0 ? * SUN *'; 

    @AuraEnabled
    public static void setCRONExpression(String newCRON){
        CRON = newCRON;
    }

    @AuraEnabled
    public static String[] getCRONExpression(){
        String[] getValues = CRON.split(' ');
        getValues.remove(6);
        getValues.remove(4);
        getValues.remove(3);
        getValues.remove(0);
        return getValues;
    }
}
