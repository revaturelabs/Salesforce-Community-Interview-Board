trigger UserStackTrigger on User_Stack__c (after insert) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
           // UserStackTriggerHelper.createComplete(Trigger.new);
        }
    }
}