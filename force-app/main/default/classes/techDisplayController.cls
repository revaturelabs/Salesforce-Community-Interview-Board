public class techDisplayController {
    @AuraEnabled
    public static List<Primary_Tech__c> getTech(){
        Id Userid = userInfo.getUserId();
        List<User_Stack__c> sl = [SELECT Name, Stack__c FROM User_Stack__c WHERE User__c=:UserId];
        List<id> idList = new List<Id>();
        for(User_Stack__c su:sl){
            idList.add(su.stack__c);
        }
        List<Stack__c> stacks = [SELECT Name,Id FROM Stack__c WHERE Id in :idList];
        List<String> ptSet= new List<String>();
        List<Primary_Tech__c> ptSetTwo= new List<Primary_Tech__c>();
        for(Stack_Tech__c s: [SELECT Name,Id,Primary_Tech__c,Stack__c FROM Stack_Tech__c]){
            for(Stack__c st: stacks){
                if(st.id == s.Stack__c && !ptSet.contains(s.Primary_Tech__c)){
                    ptSet.add(s.Primary_Tech__c);
                }
            }
        }
        integer x = 0;
        for(Primary_Tech__c p:[SELECT Name, Id FROM Primary_Tech__c]){
            if(ptSet.contains(p.id)){
                ptSetTwo.add(p);
            }
        }
        system.debug(ptSetTwo);
        return ptSetTwo;
    }
}