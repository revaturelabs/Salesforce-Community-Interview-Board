public with sharing class ProfileApex {

    
    public static id userid;
   
    public static map<id,integer> highestscore=new map<id,integer>();
    public static list<completion__c> complitionlistcheck=new list<completion__c>();
    public static list<Challenge__c> challengelist=new list<Challenge__c>();
    public static list<Challenge__c> chalistscore=new list<Challenge__c>();
    //public static map<string,map<id,integer>> techscoreinfo=new map<string,map<id,integer>>();
    
    public static map<id,integer> primarytechlowestscore=new map<id,integer>();
    public static map<id,integer> stacklowestscore=new map<id,integer>();
    
     public static list<id> AssignedStackuserid=new list<id>();
     public static list<id> AssignedPrimarytechid=new list<id>();
     public static list<id> AssignedSubTechid=new list<id>();
    public static list<id> AssignedChallengeid=new list<id>();
     public static list<id> AssignedCompletionid=new list<id>();
    
    // this method is created for testing code in Apex Class
    /*public static void callAllMethods()
    {
       
        
        ProfileApex.getSubTech();
        profileApex.getPrimaryTech();
        ProfileApex.getstackTech();
    }*/
    //this is setup method to set base value for all Assignedid list to user in other functions
    @AuraEnabled
    public static void setupAssignment()
    {
        //system.debug('inside setupAssignment');
       
        /*What-------------> Where
         PrimaryTechIDs-------->Stack_Tech__c using stackid
		SubTechIDs-------->Sub_Tech__c using primarytechids
		ChallengeIDs----->Challenge__c using Subtechids
		CompletionIDs -------> Completion__c using ChallangeIDs and UserID*/
        
        userid=UserInfo.getUserId();
       list<user_stack__c> userstackinfo=[select stack__c from user_stack__c where user__c=:userid];
        for(user_stack__c us:userstackinfo)
        {
        Assignedstackuserid.add(us.stack__c);
        }
        
         list<stack_tech__c> PrimaryTechinfo=[select Primary_tech__c from stack_tech__c where Stack__c in:(Assignedstackuserid)];
        for(stack_tech__c st:PrimaryTechinfo)
        {
        AssignedPrimarytechid.add(st.Primary_tech__c);
        }
        
        list<sub_tech__c> SubTechInfo=[select id from Sub_Tech__c where Primary_Tech__c in :(AssignedPrimarytechid)];
        for(sub_tech__c st:SubTechInfo)
        {
        AssignedSubTechid.add(st.id);
        }
        
        list<Challenge__c> challengeinfo=[select id from Challenge__c where Sub_Tech__c in :(AssignedSubTechid)];
        for(Challenge__c c:challengeinfo)
        {
        AssignedChallengeid.add(c.id);
        }
        list<Completion__c> completioninfo=[select id from Completion__c where Challenge__c in:(AssignedChallengeid) and User__c =: userid];
         for(Completion__c c:completioninfo)
        {
        AssignedCompletionid.add(c.id);
        }
        
        
       
       complitionlistcheck=[select Challenge__c from completion__c where id in:(AssignedCompletionid) and user__c=:userid and Completed__c=:true];
        
        
        challengelist=[select id,Name,Score__c,Sub_Tech__c from Challenge__c where id in :(AssignedChallengeid)];
        
       // system.debug('complitionlistcheck'+complitionlistcheck);
              
        //This is implementation of getting score and related subTech from Completed Challenge
   
           for(challenge__c cha:challengelist)
           {
                for(completion__c comp:complitionlistcheck)
        			{
          			  id idcha=cha.id;
                       id idcomp=comp.Challenge__c;
                        if(idcha==idcomp)
                        {
                            chalistscore.add(cha);
                        }		
        			}
    		}
         profileApex.findcompletedChallengeScore();
        //system.debug(chalistscore);
       
    }
    
    //this method is for finding score for completed challenges
    @AuraEnabled
     public static void findcompletedChallengeScore()
    {
      
         //system.debug('inside findcompletedChallengeScore');
       list<id> subtechidinfo=new list<id>();
        for(challenge__c chell:challengelist)
        {
            subtechidinfo.add(chell.Sub_Tech__c);
        }
        
        list<sub_tech__c> subTechList=[select id,name,Primary_Tech__c from sub_tech__c where id in :(AssignedSubTechid)];
   
        for(sub_tech__c stech:subtechlist)
        {
            
            id subtechid=stech.Id;
            highestscore.put(subtechid,0);
            for(challenge__c chell1:chalistscore)
            {
                
                id challengeid=chell1.sub_tech__c;
                if(subtechid==challengeid)
                {
                    if(chell1.Score__c>highestscore.get(subtechid))
                    {
                    
                      highestscore.put(subtechid,(integer)chell1.score__c);  
                    }
                }
            }
        }
    }
    //this method will return current username
    @AuraEnabled
    public static string Username()
    {
        //system.debug('inside Username');
         //ProfileApex.setupAssignment();
        string username;
        userid=UserInfo.getUserId();
        id ustackid,stackid;
        
        string soqlQuery ='select id,name,Username from user where id='+'\''+ Userid +'\'';
        list<user> userList= database.query(soqlQuery);

        for(user user1:userlist)
        {
            username=user1.Name;
        }
      
        return username;
    }
     //this method is for finding highest score of the of sub_tech based on completed Assigned challenges 
     @AuraEnabled
    public static map<string,integer> getSubTech()
    {
             ProfileApex.setupAssignment();
              //system.debug('inside getSubTech');
        //system.debug(' getSubTech'+AssignedSubTechid);
        list<sub_tech__c> completedSubTech=[select name from sub_tech__c where id in :(AssignedSubTechid)];
      
        list<integer> score=new list<integer>();
        list<sub_tech__c> subtech1=new list<sub_tech__c>();
        
        for(id id1:AssignedSubTechid)
        {
            for(sub_tech__c st:completedSubTech)
            {
                if(st.id==id1)
                {
                    subtech1.add(st);
                }
            }
         score.add(highestscore.get(id1));       
         }
 
        list<string> SubTechNameString=new list<string>();
        
        for(sub_tech__c s:subtech1)
        {
            SubTechNameString.add(s.Name);
        	
        }
      
        //this map contains the value that is returned to helper
        map<string,integer> highestsubtech=new map<string,integer>();
       
        for(integer i=0;i<score.size();i++)
        {
            highestsubtech.put(SubTechNameString[i],score[i]);
            
        }
       system.debug(highestsubtech);
        return highestsubtech;
    }
    //this method is for finding lowest score of the primary tech based on sub_tech
     @AuraEnabled
    Public Static map<string,integer> getPrimaryTech()
    {
          ProfileApex.setupAssignment();
           //system.debug('inside getPrimaryTech');
        list<sub_tech__c> subTechList=[select name,Primary_Tech__c from sub_tech__c where id in :(AssignedSubTechid)];
   	//this for loop will find primary tech id that has low score and store that id and score in map which is declared on top as public static 
        for(sub_tech__c stech:subtechlist)
        {
            id primarytechid=stech.Primary_Tech__c;
            
            if(primarytechlowestscore.get(primarytechid)==null)
            {
            primarytechlowestscore.put(primarytechid,highestscore.get(stech.Id));    
            }
            if(highestscore.get(stech.Id)<primarytechlowestscore.get(primarytechid))
            {
                primarytechlowestscore.put(primarytechid,highestscore.get(stech.Id));    
            }
        }   
            //system.debug('primarytechlowestscore---'+primarytechlowestscore);
            //this section of code will find name related to id and send that to helper
            map<string,integer> lowestprimarytech=new map<string,integer>();
            set<id> primarytechname=primarytechlowestscore.keySet();
        
        	list<id> primarytechnamelist1=new list<id>(primarytechname);
            list<primary_tech__c> primarytechnamelist=[select name,id from primary_tech__c where id in:(primarytechnamelist1)];
            
        	list<string> primarytechnamestring=new list<string>();
            list<integer> primaryscore=new list<integer>();
            for(primary_tech__c pt:primarytechnamelist)
            {
                lowestprimarytech.put(pt.Name,primarytechlowestscore.get(pt.Id));
            }
          
            system.debug(lowestprimarytech);
            return lowestprimarytech;
          
 	}
   
    //this method is for finding lowest score of the assigned Stack based on stack_Tech
     @AuraEnabled
    Public Static map<string,integer> getstackTech()
    {
         ProfileApex.setupAssignment();
         //system.debug('inside getstackTech');
        list<stack_tech__c> stackTechList=[select name,Stack__c,Primary_Tech__c from stack_tech__c where Primary_Tech__c in :(AssignedPrimarytechid)];
   		 list<sub_tech__c> subTechList=[select name,Primary_Tech__c from sub_tech__c where id in :(AssignedSubTechid)];
        //this for loop will find stack tech id that has low score and store that id and score in map which is declared on top as public static 
        for(stack_tech__c stech:stackTechList)
        {
            id stacktechid=stech.Stack__c;
            id pt=stech.Primary_Tech__c;
            for(sub_tech__c st:subTechList)
            {
            id primerytechid=st.Primary_Tech__c;
             
                if(primerytechid==pt)
                {
            		if(stacklowestscore.get(stacktechid)==null)
            		{
            		stacklowestscore.put(stacktechid,highestscore.get(st.Id));    
            		}
            		if(highestscore.get(stech.Id)<stacklowestscore.get(stacktechid))
            		{
                	stacklowestscore.put(stacktechid,highestscore.get(st.Id));    
            		}
            	}
        	}  
        }
             //system.debug('stacklowestscore---'+stacklowestscore);
             
        //this section of code will find name related to id and send that to helper 
            map<string,integer> loweststacktech=new map<string,integer>();
            set<id> stacktechname=stacklowestscore.keySet();
        
        	list<id> stacktechnamelist1=new list<id>(stacktechname);
            list<stack_tech__c> stacktechnamelist=[select name,id from stack_tech__c where stack__c in:(stacktechnamelist1)];
           
        	list<id> stackid=new list<id>();
        	for(stack_tech__c st_c:stacktechnamelist)
            {
                stackid.add(st_c.Id);
            }
        	list<stack__c> stacklist=[select name,id from stack__c where id in:(stacktechname)];
        
        	list<string> stacknamestring=new list<string>();
            list<integer> stackscore=new list<integer>();
            for(stack__c pt:stacklist)
            {
                loweststacktech.put(pt.Name,stacklowestscore.get(pt.Id));
            }
          
            system.debug(loweststacktech);
        return loweststacktech;
     
 	}
}