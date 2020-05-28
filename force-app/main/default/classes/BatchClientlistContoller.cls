public with sharing class BatchClientlistContoller {
    @AuraEnabled
    public static PageWrapper fetchBatchClient(Decimal pageNumber ,Integer recordToDisply) {
         Integer pageSize = recordToDisply;
         Integer offset = ((Integer)pageNumber - 1) * pageSize;
       
       // create a instance of wrapper class.
       PageWrapper obj =  new PageWrapper();
       // set the pageSize,Page(Number), total records and accounts List(using OFFSET)   
           obj.pageSize = pageSize;
           obj.page = (Integer) pageNumber;
           obj.total = [SELECT count() FROM Batch_Client__c];
           obj.BatchClient = [SELECT Name,Interested_Client__r.Name,Batch__r.Name FROM Batch_Client__c LIMIT :recordToDisply OFFSET :offset];
       // return the wrapper class instance .
           return obj;
        }
       
    // create a wrapper class with @AuraEnabled Properties    
    public class PageWrapper {
       @AuraEnabled public Integer pageSize {get;set;}
       @AuraEnabled public Integer page {get;set;}
       @AuraEnabled public Integer total {get;set;}
       @AuraEnabled public List<Batch_Client__c> BatchClient {get;set;}
      }
}
