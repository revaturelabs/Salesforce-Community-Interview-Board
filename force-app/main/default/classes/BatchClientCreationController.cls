public class BatchClientCreationController {

    //Get all account records with the batch recordtype id
    @AuraEnabled
    public static List<Account> getBatchAccounts(){
        String batchRecordTypeId = '0125w000000LYXSAA4';
        //Final batch Record Type id => 0125w000001PYxsAAG

        return [SELECT Name, Id FROM Account WHERE RecordTypeId =: batchRecordTypeId];  
    }

    //Get all account records with the client recordtype id
    @AuraEnabled
    public static List<Account> getClientAccounts(){
        String clientRecordTypeId = '0125w000000LYXTAA4';
        //Final Client Record Type id => 0125w000001PYxtAAG

        return [SELECT Name, Id FROM Account WHERE RecordTypeId =: clientRecordTypeId];   
    }
    
    //create a batch client record based on user input.
    @AuraEnabled
    public static void createBatchClientObj(String batchId, String clientId, String name){
  
        Batch_Client__c batchClient = new Batch_Client__c();
        batchClient.Name = name;
        batchClient.Interested_Client__c =clientId;
        batchClient.Batch__c =batchId;
        System.debug('batchClient => ' + batchClient);
        insert batchClient;
    }

}