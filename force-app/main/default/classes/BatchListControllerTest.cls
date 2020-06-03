@isTest
public with sharing class BatchListControllerTest {
    
    @TestSetup
    static void makeData(){
    List<Account> AccountsList= new List<Account>();
    List<Batch_Client__c> BatchList = new List<Batch_Client__c>();
    for(integer i = 0 ; i < 20 ; i++){
        Account A = new Account();
        A.name='test'+i;
    
        AccountsList.add(A);
  }
    insert AccountsList;
    for(integer i = 0 ; i < 10 ; i++)
    {
        Batch_Client__c C = new Batch_Client__c();
        C.Interested_Client__c = AccountsList[i+10].id;
        C.Batch__c= AccountsList[i].id;
        BatchList.add(C);
  }
  
    insert BatchList;
}
      
    @isTest
    public static void testLoadData(){
        //this test method is made by testing that the variables in the wrapper class are changed properly
        BatchClientlistContoller.PageWrapper  myPageWrapper = BatchClientlistContoller.LoadData(1,10);
  
        System.assert(myPageWrapper.pageSize == Null);
        System.assert(myPageWrapper.page == 1);
        System.assert(myPageWrapper.total == [SELECT count() FROM Batch_Client__c]);
        System.assert(myPageWrapper.BatchClient == [SELECT Name,Interested_Client__r.Name,Batch__r.Name FROM Batch_Client__c LIMIT 10 OFFSET 0] );
        System.assert(myPageWrapper.BatchList == [SELECT name FROM Account WHERE RecordType.DeveloperName ='Batch'] );
        
      }
  
    @isTest
    public static void testFetchBatchClient(){
        Test.startTest();
        //test that the variables in the wrapper class are changed properly
        BatchClientlistContoller.PageWrapper myPageWrapper2 = BatchClientlistContoller.fetchBatchClient(1, 10, 'ALL');
        System.assert(myPageWrapper2.pageSize == 10);
        System.assert(myPageWrapper2.page == 1);
        System.assert(myPageWrapper2.total == [SELECT count() FROM Batch_Client__c]);
        System.assert(myPageWrapper2.BatchClient == [SELECT Name,Interested_Client__r.Name,Batch__r.Name FROM Batch_Client__c LIMIT 10 OFFSET 0]);
       
        


        //same as above, but with 'test1' picklist value instead of 'ALL'
        BatchClientlistContoller.PageWrapper myPageWrapper3 = BatchClientlistContoller.fetchBatchClient(1, 5, 'test1');
        System.assert(myPageWrapper3.pageSize == 5);
        System.assert(myPageWrapper3.page == 1);
        System.assert(myPageWrapper3.total == [SELECT count() FROM Batch_Client__c]);
        System.assert(myPageWrapper3.BatchClient == [SELECT Name,Interested_Client__r.Name,Batch__r.Name FROM Batch_Client__c WHERE Batch__r.Name='test1' LIMIT 5 OFFSET 0]);
        System.assert(myPageWrapper3.BatchClient.size()==1);
        
       Test.stopTest();
    }
  
}