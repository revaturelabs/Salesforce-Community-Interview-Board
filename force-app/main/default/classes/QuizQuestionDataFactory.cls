public class QuizQuestionDataFactory {
    
    public static void CreateAllQuestions(){
        
        SalesforceQuestion();
        dotNetQuestion();
        JavaQuestion();
    }
    @TestVisible  
    private static void SalesforceQuestion(){

        
        List<Quiz_Question__c> questionList = new List<Quiz_Question__c>();
        Quiz_Question__c sampleQuestion = new Quiz_Question__c();
        sampleQuestion.Label__c = 'How would a developer determine if a CustomObject__c record has been manually shared with the current user in Apex?';
        sampleQuestion.Answer_A__c = 'By calling the isShared() method for the record.';
        sampleQuestion.Answer_B__c = 'By querying the role hierarchy.';
        sampleQuestion.Answer_C__c = 'By querying CustomObject__share.';
        sampleQuestion.Answer_D__c = 'By calling the profile settings of the current user.';
        sampleQuestion.Correct_Answer__c = 'C';
        sampleQuestion.Stack__c = 'Salesforce';
        sampleQuestion.Type__c = 'Apex';        
        questionList.add(sampleQuestion);
        sampleQuestion = new Quiz_Question__c();
        
        sampleQuestion.Label__c = 'The methods of Schema.sObjectType.OBJECT behave in which of the following ways?';
        sampleQuestion.Answer_A__c = 'It removes any results the context user has insufficient permissions for.';
        sampleQuestion.Answer_B__c = 'It returns an empty list if the context user has insufficient permissions.';
        sampleQuestion.Answer_C__c = 'It returns a boolean value denoting if the context user has the specified permission.';
        sampleQuestion.Answer_D__c = 'It throws an error noting the context user has insufficient permissions.';
        sampleQuestion.Correct_Answer__c = 'C';
        sampleQuestion.Stack__c = 'Salesforce';
        sampleQuestion.Type__c = 'Apex';           
        
        questionList.add(sampleQuestion);
        
        insert questionList;
        
    }
    @TestVisible
    private static void dotNetQuestion(){
                
        List<Quiz_Question__c> questionList = new List<Quiz_Question__c>();
        Quiz_Question__c sampleQuestion = new Quiz_Question__c();
        sampleQuestion.Label__c = 'A variable which is declared inside a method is called a________variable?';
        sampleQuestion.Answer_A__c = 'Serial';
        sampleQuestion.Answer_B__c = 'Local';
        sampleQuestion.Answer_C__c = 'Private';
        sampleQuestion.Answer_D__c = 'Static';
        sampleQuestion.Correct_Answer__c = 'B';
        sampleQuestion.Stack__c = '.Net';
        sampleQuestion.Type__c = 'C#';        
        questionList.add(sampleQuestion);
        sampleQuestion = new Quiz_Question__c();
        
        sampleQuestion.Label__c = ' An Event has _____ as default return type?';
        sampleQuestion.Answer_A__c = 'No return type for events';
        sampleQuestion.Answer_B__c = 'Double';
        sampleQuestion.Answer_C__c = 'Integer';
        sampleQuestion.Answer_D__c = 'String';
        sampleQuestion.Correct_Answer__c = 'C';
        sampleQuestion.Stack__c = '.Net';
        sampleQuestion.Type__c = 'C#';           
        
        questionList.add(sampleQuestion);
        
        insert questionList;
        
        
    }
    @TestVisible
    private static void JavaQuestion(){
        
        List<Quiz_Question__c> questionList = new List<Quiz_Question__c>();
        Quiz_Question__c sampleQuestion = new Quiz_Question__c();
        sampleQuestion.Label__c = 'Which of the following is not a Java features?';
        sampleQuestion.Answer_A__c = 'Dynamic';
        sampleQuestion.Answer_B__c = 'Architecture Neutral';
        sampleQuestion.Answer_C__c = 'Use of pointers';
        sampleQuestion.Answer_D__c = 'Object-oriented';
        sampleQuestion.Correct_Answer__c = 'C';
        sampleQuestion.Stack__c = 'Java';
        sampleQuestion.Type__c = 'Java';        
        questionList.add(sampleQuestion);
        sampleQuestion = new Quiz_Question__c();
        
        sampleQuestion.Label__c = '_____ is used to find and fix bugs in the Java programs.';
        sampleQuestion.Answer_A__c = 'JVM';
        sampleQuestion.Answer_B__c = 'JRE';
        sampleQuestion.Answer_C__c = 'JDK';
        sampleQuestion.Answer_D__c = 'JDB';
        sampleQuestion.Correct_Answer__c = 'D';
        sampleQuestion.Stack__c = 'Java';
        sampleQuestion.Type__c = 'Java';           
        
        questionList.add(sampleQuestion);
        
        insert questionList;        
    } 
}