public with sharing class ProfileApex {

    public static list<Challenge__c> chalistscore=new list<Challenge__c>();
    public static id userid;
    @AuraEnabled
    public static void FindHigestScore()
    {
        userid=UserInfo.getUserId();
        Boolean challangecompleted=True;
        string soqlQuery1 ='select Challenge__c from completion__c where Completed__c= '+ challangecompleted+ ' and user__c= '+'\''+ Userid +'\'';
        list<completion__c> complitionlistcheck=database.query(soqlQuery1);
        
         string soqlQuery2 ='select id,Name,Score__c,Sub_Tech__c from Challenge__c order by Score__c desc';
        list<Challenge__c> challengelist=database.query(soqlQuery2);
        
        system.debug(complitionlistcheck);
              
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
        
        system.debug(chalistscore);
       
    }
    @AuraEnabled
    public static map<sub_tech__c,integer> getSubTech()
    {
       ProfileApex.FindHigestScore();
        
        string soqlQuery1 ='select id,Name,Primary_Tech__c from Sub_Tech__c';
        list<sub_tech__c> subTechList=database.query(soqlQuery1);
        
        set<sub_tech__c> subTechSet=new set<sub_tech__c>();
        
         map<id,integer> highestscore=new map<id,integer>();
      
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
        
         //set<id> getsubtechid=new set<id>();
        list<id> getsubtechid=new list<id>(highestscore.keySet());
       system.debug(getsubtechid);
        /*for(map<id,integer> mapid:highestscore)
        {
            //getsubtechid.add(mapid.key());
        }*/
        list<sub_tech__c> l1=[select name,id from sub_tech__c where id in :(getsubtechid)];
      
        list<integer> score=new list<integer>();
        list<sub_tech__c> st1=new list<sub_tech__c>();
        for(id id1:getsubtechid)
        {
            for(sub_tech__c st:l1)
            {
                if(st.id==id1)
                {
                    st1.add(st);
                }
            }
         score.add(highestscore.get(id1));       
         }
        
        system.debug(score);
           
        system.debug(l1);
        system.debug(highestscore);
        
        map<sub_tech__c,integer> highestsubtech=new map<sub_tech__c,integer>();
        for(integer i=0;i<score.size();i++)
        {
            highestsubtech.put(st1[i],score[i]);
        }
        system.debug(highestsubtech);
        return highestsubtech;
    }
    
    //this method is created to find the current user information and display that on aura component
    @AuraEnabled
    public static string Username()
    {
        string username;
        userid=UserInfo.getUserId();
        id ustackid,stackid;
        
        string soqlQuery ='select id,name,Username from user where id='+'\''+ Userid +'\'';
        list<user> userList= database.query(soqlQuery);

        for(user user1:userlist)
        {
            username=user1.Name;
        }
        system.debug(username);
        return username;
    }
    //this method contains all the stacks assigned to the user who is using component
    @AuraEnabled
    public static list<stack__c> AssignedStack()
    {
       userid=UserInfo.getUserId();
        id ustackid,stackid;
        /*string soqlQuery ='select id,name,Username from user where id='+'\''+ Userid +'\'';
        list<user> userList= database.query(soqlQuery);
         system.debug(userlist);
        */
        string soqlQuery1 ='select id,Name,Stack__c,User__c from User_Stack__C where User__c= '+'\''+ Userid +'\'';
        list<user_stack__c> userStackList= database.query(soqlQuery1);
        system.debug(userstacklist);
        set<stack__c> Assignedstacknamelist=new set<stack__c>();
        
        list<stack__c> StackList=[select id,name from stack__c];
        
        system.debug(stacklist);
        for(user_stack__c ustack:userStackList)
        {
            for(stack__c stack:StackList)
            {
                stackid=stack.Id;
                ustackid=ustack.stack__c;
                if(stackid==ustackid)
                {
                    Assignedstacknamelist.add(stack);
                }
            }
        }
        //because i am not able to return set<stack__c> i am converting set into list and return list
        system.debug('Assigned Stack List:-'+Assignedstacknamelist);
        List<stack__c> convertsettolist = new List<stack__c>(Assignedstacknamelist);
        return convertsettolist;
    }
}