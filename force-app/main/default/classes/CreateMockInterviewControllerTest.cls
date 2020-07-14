@isTest
public class CreateMockInterviewControllerTest {
    @isTest
    public static void getTypePicklistValuesTest() {
        Map<String,List<String>> returnedMap = CreateMockInterviewController.getTypePicklistValues();
        List<String> salesforceTypes = new List<String>{'Soft Skills','Apex', 'Apex Trigger','Apex Testing', 'Visualforce','Aura/Lightning Components', 'Declarative Salesforce', 'SOQL/SOSL', 'HTML/CSS', 'JavaScript'};
        List<String> javaTypes = new List<String>{'Soft Skills', 'Java', 'React', 'Spring', 'Typescript', 'Node.Js', 'JavaScript'};
        List<String> netTypes = new List<String>{'Soft Skills', 'C#', 'C++', 'SQL', 'JavaScript', 'Python', 'C'};
        Map<String, List<String>> testMap = new Map<String, List<String>>{'Salesforce'=> salesforceTypes, 'Java'=> javaTypes, '.NET'=> netTypes};
        System.assertEquals(testMap, returnedMap);
    }

    @TestSetup
    static void makeQuestions(){
        List<Question__c> allQuestions = new List<Question__c>();
            for (Integer i= 0; i<100; i++) {
                Integer mod = Math.mod(i,3);
                Question__c question = new Question__c();
                switch on mod {
                    when 0 {

                        question.Name= 'Apex'+i;
                        question.Stack__c='Salesforce';
                        question.Type__c='Apex';

                    }
                    when 1 {
                        question.Name='Visualforce'+i;
                        question.Stack__c='Salesforce';
                        question.Type__c='Visualforce';

                    }
                    when 2 {
                        question.Name='Java'+i;
                        question.Stack__c='Java';
                        question.Type__c='Java';
                    }

                }
                allQuestions.add(question);
            }
            insert allQuestions;
    }

    @isTest
    public static void createMockInterviewPositiveTest() {
        List<String> types = new List<String>{'Apex', 'Visualforce'};
        CreateMockInterviewController.createMockInterview(20, types);
        Integer gotQuestions = [SELECT COUNT() FROM Interview_Question__c WHERE Meeting__r.Name = 'Mock interview with 20 questions'];
        //AggregateResult numQuestion = gotQuestions[0];
        System.assertEquals(20, gotQuestions);
    }
    @isTest
    public static void createMockInterviewNegativeTest() {
        List<String> types = new List<String>{'Apex', 'Visualforce'};
        CreateMockInterviewController.createMockInterview(null, types);
        Integer gotQuestions = [SELECT COUNT() FROM Interview_Question__c WHERE Meeting__r.Name = 'Mock interview with Null questions'];
        //AggregateResult numQuestion = gotQuestions[0];
        System.assertNotEquals(null, gotQuestions);
    }
}