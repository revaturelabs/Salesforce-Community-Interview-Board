global class SyncSchedule implements Schedulable {
    global void execute(SchedulableContext SC) {
        SyncUtilityClass util = new SyncUtilityClass();
        util.updateDatabase();
    }
}