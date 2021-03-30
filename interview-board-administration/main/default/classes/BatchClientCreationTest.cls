@isTest
public without sharing class BatchClientCreationTest {

   @TestSetup
    public static void createRecords(){
        
        //create the account records with appropriate record type for both
        //'0125w000000LYXSAA4' client recordtype id
        //'0125w000000LYXTAA4' batch recordtype id
        
        Id batchTypeId =
            Schema.SObjectType.Account.getRecordTypeInfosByName().get('Batch').getRecordTypeId();

        Account alpha = new Account();
        alpha.Name = 'Johnson';
        alpha.RecordTypeId = batchTypeId;

        Id clientTypeId =
            Schema.SObjectType.Account.getRecordTypeInfosByName().get('Client').getRecordTypeId();
        
        Account beta = new Account();
		beta.Name = 'Anderson';
        beta.RecordTypeId = clientTypeId;

        //insert records
        insert alpha;
        insert beta;
    }

    @isTest
    public static void testMethod1(){
     List<Account> client = BatchClientCreationController.getBatchAccounts();
        System.assertEquals('Johnson', client[0].Name);
    }
    
    
    @isTest
    public static void testMethod2(){
     List<Account> client = BatchClientCreationController.getClientAccounts();
        System.assertEquals('Anderson', client[0].Name);
    }
    
    
      
    @isTest
    public static void testMethod3(){
        
        
        Account cl = [Select ID, name From Account where Name ='Anderson' Limit 1];
        Account ba = [Select ID, name From Account where Name ='Johnson' Limit 1];
		String clId = cl.id;
        String baId = ba.id;

    	BatchClientCreationController.createBatchClientObj(cl.id, ba.id,'supercalifragilisticexpialidocious');
        
         Batch_Client__c  charlie = [Select Name, Id, Batch__c, Interested_Client__c From  Batch_Client__c  where name ='supercalifragilisticexpialidocious' Limit 1];
         System.assertEquals(clId,   charlie.Batch__c);
         System.assertEquals(baId,  charlie.Interested_Client__c);
    }
    
    
}