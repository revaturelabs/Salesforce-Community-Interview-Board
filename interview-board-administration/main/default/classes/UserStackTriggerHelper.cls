public class UserStackTriggerHelper {
    public static void createComplete(List<User_Stack__c> useStacks){
        List<Id> userIDs = new List<Id>();
        List<Id> stackIDs = new List<Id>();
        for(User_Stack__c us: useStacks){
            stackIDs.add(us.Stack__c);
            userIDs.add(us.User__c);
        }
        List<Stack_Tech__c> sTechs = [SELECT Primary_Tech__c FROM Stack_Tech__c WHERE Stack__c IN :stackIDs];
        List<Id> primeTechIDs = new List<Id>();
        for(Stack_Tech__c st: sTechs){
            if(!(primeTechIDs.contains(st.Primary_Tech__c))){
            	primeTechIDs.add(st.Primary_Tech__c);
            }
        }
        List<Sub_Tech__c> subTechs = [SELECT Id FROM Sub_Tech__c WHERE Primary_Tech__c IN :primeTechIDs];
        List<Id> subTechIDs = new List<Id>();
        for(Sub_Tech__c subt: subTechs){
            subTechIDs.add(subt.id);
        }
        List<Challenge__c> challs = [SELECT Id FROM Challenge__c WHERE Sub_Tech__c IN :subTechIDs];
        List<Id> challIDs = new List<Id>();
        for(Challenge__c chall: challs){
            challIDs.add(chall.id);
        }
        List<Completion__c> comps =[SELECT User__c, Challenge__c FROM Completion__c WHERE User__c IN :userIDs AND Challenge__c IN :challIDs];
        Set<Completion__c> newComps = new Set<Completion__c>();
        for(Id userId: userIDs){
            for(Id challID: challIDs){
                Completion__c comp = new Completion__c();
                comp.Challenge__c = challID;
                comp.User__c = userId;
                comp.Completed__c = false;
                newComps.add(comp);
            }
        }
        for(Completion__c newComp: newComps){
            for(Completion__c oldComp: comps){
                if(newComp.Challenge__c == oldComp.Challenge__c && newComp.User__c == oldComp.User__c){
                    newComps.remove(newComp);
                }
            }
        }
        //Needs to be a List to insert in to Database
        List<Completion__c> newCompsL = new List<Completion__c>(newComps);
        insert newCompsL;
    }
}