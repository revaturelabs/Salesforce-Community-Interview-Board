public with sharing class BatchClientlistContoller {
     @AuraEnabled
     public static PageWrapper LoadData(Decimal pageNumber ,Integer recordToDisply)
     {    Integer pageSize = recordToDisply; //Determine number of records to display based on input value
          Integer offset = ((Integer)pageNumber - 1) * pageSize; //deals with pagination
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
       @AuraEnabled public Integer pageSize {get;set;}//5, 10, or 20
       @AuraEnabled public Integer page {get;set;} //page you're on
       @AuraEnabled public Integer total {get;set;} //total number of pages
       @AuraEnabled public List<Batch_Client__c> BatchClient {get;set;}//The records to be displayed
       @AuraEnabled public List<Account> BatchList {get;set;}//used for populating picklist with values 
      }
}