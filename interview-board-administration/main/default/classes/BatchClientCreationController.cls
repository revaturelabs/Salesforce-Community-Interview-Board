public class BatchClientCreationController {

    //Get all account records with the batch recordtype id
    @AuraEnabled
    public static List<Account> getBatchAccounts(){
        //In Dev branch, batch record type id should be => 0125w000001PYxsAAG
        RecordType batch = [Select name, Id from RecordType where sObjectType='Account' and Name = 'Batch' Limit 1];
        String batchRecordTypeId = batch.id;

        Id batchTypeId =
            Schema.SObjectType.Account.getRecordTypeInfosByName().get('Batch').getRecordTypeId();

        return [SELECT Name, Id FROM Account WHERE RecordTypeId =: batchTypeId];  
    }

    //Get all account records with the client recordtype id
    @AuraEnabled
    public static List<Account> getClientAccounts(){
        //In Dev branch, client record type id should be => 0125w000001PYxtAAG
        RecordType client = [Select name, Id from RecordType where sObjectType='Account' and Name = 'Client' Limit 1];
        String clientRecordTypeId = client.id;
        
        Id clientTypeId =
            Schema.SObjectType.Account.getRecordTypeInfosByName().get('Client').getRecordTypeId();

        return [SELECT Name, Id FROM Account WHERE RecordTypeId =: clientTypeId];   
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