@isTest
public class CreateMockInterviewControllerTest {
    @isTest
    public static void getTypePicklistValuesTest() {
        Map<String,List<String>> returnedMap = CreateMockInterviewController.getTypePicklistValues();
        List<String> salesforceTypes = new List<String>{'Soft Skills','Apex', 'Apex Trigger','Apex Testing', 'Visualforce','Aura/Lightning Components', 'Declarative Salesforce', 'SOQL/SOSL', 'HTML/CSS', 'JavaScript'};
        List<String> javaTypes = new List<String>{'Soft Skills', 'Java', 'React', 'Spring', 'Typescript', 'Node.Js', 'JavaScript'};
        List<String> netTypes = new List<String>{'Soft Skills', 'C#', 'C++', 'SQL', 'JavaScript', 'Python', 'C'};
        List<String> PCTypes = new List<String>{'Fun'};
        Map<String, List<String>> testMap = new Map<String, List<String>>{'Salesforce'=> salesforceTypes, 'Java'=> javaTypes, '.NET'=> netTypes, 'Pop Culture' => PCTypes};
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

                    question.Stack__c='Salesforce';
                    question.Type__c='Apex';

                }
                when 1 {
                    
                    question.Stack__c='Salesforce';
                    question.Type__c='Visualforce';

                }
                when 2 {
                    
                    question.Stack__c='Java';
                    question.Type__c='Java';
                }

            }
            allQuestions.add(question);
        }
        insert allQuestions;

    //     Account testAcc = new Account();
    //     testAcc.name = 'test company';
    //     Database.SaveResult savedAccount = Database.insert(testAcc);
    //     Id accID = savedAccount.getId();
        
        
    //     Contact con = new Contact(lastname = 'stuff', AccountId = accId);
    //     Database.SaveResult savedContact = Database.insert(con);

    //     Id contId = savedContact.getId();
    //     Profile prof = [SELECT id FROM Profile WHERE Name = 'Associate'];
        
    //     User u = new User(firstName = 'test1', lastName ='stuff', profileId = prof.id, 
    //                       username = 'test@test.com', email = 'test@test.com', ContactId = contId,
    //                       alias= 'Test', TimeZoneSidKey='America/New_York', LocaleSidKey='en_US',
    //                       EmailEncodingKey='ISO-8859-1', LanguageLocaleKey='en_US', IsActive = true);
    //     insert u;
     }

    @isTest
    public static void createMockInterviewPositiveTest() {
        // User testUser = [SELECT id FROM User WHERE lastName='stuff']; 
        
        // Contact conta = [SELECT id FROM Contact WHERE lastname='stuff'];

        // System.runAs(testUser) {
            List<String> types = new List<String>{'Apex', 'Visualforce'};
            CreateMockInterviewController.createMockInterview(21, types);
            List<Interview_Question__c> gotQuestions = [SELECT Question__r.type__c FROM Interview_Question__c WHERE Meeting_md__r.Name = 'Mock interview with 21 questions'];
            //AggregateResult numQuestion = gotQuestions[0];
            Integer aCount = 0;
            Integer vCount = 0;
            for(Interview_Question__c iQ : gotQuestions) {
                if(iQ.Question__r.type__c=='Apex') aCount++;
                if(iQ.Question__r.type__c=='Visualforce') vCount++;
                
            }
            System.assertEquals(11, aCount);
            System.assertEquals(10, vCount);
    //   }
    }

    @isTest
    public static void createMockInterviewNegativeTest() {
        // User testUser = [SELECT id FROM User WHERE lastName='stuff']; 
        
        // Contact conta = [SELECT id FROM Contact WHERE lastname='stuff'];

        // System.runAs(testUser) {
            List<String> types = new List<String>{'Apex', 'Visualforce'};
            CreateMockInterviewController.createMockInterview(null, types);
            Integer gotQuestions = [SELECT COUNT() FROM Interview_Question__c WHERE Meeting_md__r.Name = 'Mock interview with Null questions'];
            //AggregateResult numQuestion = gotQuestions[0];
            System.assertNotEquals(null, gotQuestions);
      //  }
    } 
}