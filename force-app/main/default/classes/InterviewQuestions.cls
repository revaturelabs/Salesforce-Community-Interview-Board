public class InterviewQuestions {
    
    @AuraEnabled
    public static Map<Id,List<Interview_Question__c>> loadQuestionMap()
    {
        Map<Id,List<Interview_Question__c>> questionMap = 
            new Map<Id,List<Interview_Question__c>>();
        List<Interview_Question__c> questions = new List<Interview_Question__c>();
        for(Meeting__c meeting : [Select Id,(Select Id,Body__c,Subject__c from Interview_Questions__r) from Meeting__c])
        {
             questionMap.put(meeting.Id,meeting.Interview_Questions__r);
    
        }
        
        /*for(Meeting__c m : [select Id from meeting__c])
        {
            for(Interview_Question__c q : questionMap.get(m.Id))
            {
                system.debug('Subject: '+q.Subject__c+'\n Question: '+q.Body__c);
            }
            
        }*/
       
        return questionMap;
    }
    
    @AuraEnabled
    public static List<Meeting__c> getMeetings()
    {
        return [select Id, Name from Meeting__c];
    }

}