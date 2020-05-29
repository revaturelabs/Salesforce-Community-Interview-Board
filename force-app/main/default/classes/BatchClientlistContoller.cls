public with sharing class BatchClientlistContoller {
     @AuraEnabled
     public static PageWrapper LoadData(Decimal pageNumber ,Integer recordToDisply)
     {    Integer pageSize = recordToDisply;
          Integer offset = ((Integer)pageNumber - 1) * pageSize;
          PageWrapper obj =  new PageWrapper();
          // Get btach client Rec type
          obj.BatchList=[SELECT name FROM Account WHERE RecordType.DeveloperName ='Batch'];
          obj.BatchClient = [SELECT Name,Interested_Client__r.Name,Batch__r.Name FROM Batch_Client__c LIMIT :recordToDisply OFFSET :offset];
          obj.page = (Integer) pageNumber;
          obj.total = [SELECT count() FROM Batch_Client__c];
          return obj;
     }
     
    @AuraEnabled
    public static PageWrapper fetchBatchClient(Decimal pageNumber ,Integer recordToDisply,string picklistV) {
         Integer pageSize = recordToDisply;
         Integer offset = ((Integer)pageNumber - 1) * pageSize;
       
       // create a instance of wrapper class.
       PageWrapper obj =  new PageWrapper();
       // set the pageSize,Page(Number), total records and accounts List(using OFFSET)   
           obj.pageSize = pageSize;
           if(picklistV=='ALL')
           {
               obj.BatchClient = [SELECT Name,Interested_Client__r.Name,Batch__r.Name FROM Batch_Client__c LIMIT :recordToDisply OFFSET :offset];
           }
     
           else{
             //other Soql to get data from pick list
             obj.BatchClient=[SELECT Name,Interested_Client__r.Name,Batch__r.Name FROM Batch_Client__c WHERE Batch__r.Name=:picklistV LIMIT :recordToDisply OFFSET :offset];
           }
           obj.page = (Integer) pageNumber;
           obj.total = [SELECT count() FROM Batch_Client__c];
       // return the wrapper class instance .
           return obj;
        }

      
    // create a wrapper class with @AuraEnabled Properties    
    public class PageWrapper {
       @AuraEnabled public Integer pageSize {get;set;}
       @AuraEnabled public Integer page {get;set;}
       @AuraEnabled public Integer total {get;set;}
       @AuraEnabled public List<Batch_Client__c> BatchClient {get;set;}
       @AuraEnabled public List<Account> BatchList {get;set;}
      }
}
