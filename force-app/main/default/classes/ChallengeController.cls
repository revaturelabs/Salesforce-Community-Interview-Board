public with sharing class ChallengeController {

    //this method is retriving detail from challenge__c object based on the Subtech selected and Challange inside that subject selected from dropdown and returing specific record
    @AuraEnabled
    public static list<challenge__c> challengeData(String recordid,String ChallangeName)
    {
        system.debug(recordid+'  '+ChallangeName);
        string soqlQuery ='select name,Details__c,Score__c,Sub_Tech__c from challenge__c where Sub_Tech__c= '+'\''+ recordid+'\''+' and name= '+'\''+ ChallangeName +'\'' +' limit 1';
       
        list<challenge__c> challengelist=database.query(soqlQuery);
        system.debug(challengelist);
        return challengelist;
       
    }
    
    
    //this method is retriving list of all the Challanges in challenge__c object based on Sub_Tech selected which is used to display Dropdown in component.
     @AuraEnabled
    public static list<challenge__c> challengeName(String recordid)
    {
        system.debug(recordid);
        string soqlQuery ='select name from challenge__c where Sub_Tech__c= '+'\''+ recordid+'\'';
        list<challenge__c> challengelist=database.query(soqlQuery);
        system.debug(challengelist);
        return challengelist;
        
    }
    
    //this method is used to perform insert,update operation on challenge__c object and if Record is already upto date then it will return Challenge Already Marked as Completed message.
    @AuraEnabled
    public static string challengecompleted(String challangeName)
    {
        
        system.debug(challangeName);
        id userid,challangeid;
        boolean completestatus;
        userid=UserInfo.getUserId();
        system.debug(userid);
        
        string soqlQuery ='select id from challenge__c where name= '+'\''+ challangeName +'\'';
         list<challenge__c> challengelist=database.query(soqlQuery);
        for(challenge__c chall:challengelist)
        {
           
            challangeid=chall.Id;
        }
      
        string soqlQuery1 ='select name,id,Challenge__c,Completed__c from completion__c where Challenge__c= '+'\''+ challangeid+'\'';//+' and Completed__c= '+'\''+ True +'\'';
        list<completion__c> complitionlistcheck=database.query(soqlQuery1);
        integer size=complitionlistcheck.size();
        
        for(completion__c comp:complitionlistcheck)
        {
           
            completestatus=comp.Completed__c;
        }
        
        if(size>=1 && completestatus==True)
        {
            system.debug('Challenge Already Marked as Completed');
            return 'Challenge Already Marked as Completed';
        }
        else if(size>=1 && completestatus==False)
        {
       
            completion__c completionToUpdate;
            
            completionToUpdate = [SELECT id,Completed__c FROM completion__c WHERE Completed__c=False AND Challenge__c=:challangeid LIMIT 1];
    
    					completionToUpdate.Completed__c = True;
  
   			update completionToUpdate;
            system.debug('Record Updated Successfully');
            return 'Record Updated Successfully';
            
           
        }
        
        
        try
        {
        Completion__c complete=new completion__c(Challenge__c=challangeid,Completed__c=True,User__c=userid);
        insert complete;
        return 'Compelete Status Updated Successfully';
        }
        catch(exception e)
        {
            return 'There is Some Error in Updating Status';
        }
    }
}