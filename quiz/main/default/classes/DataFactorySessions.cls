public with sharing class DataFactorySessions {
       	//phase picklist options may change over time ; user input string allows for flexibility and reuse in future. 
           public static void makeSessions (Integer Num, String phaseString, String phaseString2, String phaseString3) {
            List<Quiz_Session__c> quizzes = new List<Quiz_Session__c>();
            
                for(Integer i=0; i < Num; i++) {
            Quiz_Session__c newS = new Quiz_Session__c(Phase__c= phaseString, Date_and_Time__c = System.now());
            quizzes.add(newS);
               Quiz_Session__c newS1 = new Quiz_Session__c(Phase__c= phaseString2, Date_and_Time__c = System.now());
             quizzes.add(newS1);
             Quiz_Session__c newS2 = new Quiz_Session__c(Phase__c= phaseString3, Date_and_Time__c = System.now());
             quizzes.add(newS2);
                }
    insert quizzes;
    }
}