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

        Account testAcc = new Account();
        testAcc.name = 'test company';
        Database.SaveResult savedAccount = Database.insert(testAcc);
        Id accID = savedAccount.getId();
        
        
        Contact con = new Contact(lastname = 'stuff', AccountId = accId);
        Database.SaveResult savedContact = Database.insert(con);

        Id contId = savedContact.getId();
        Profile prof = [SELECT id FROM Profile WHERE Name = 'Associate'];
        
        User u = new User(firstName = 'test1', lastName ='stuff', profileId = prof.id, 
                          username = 'test@test.com', email = 'test@test.com', ContactId = contId,
                          alias= 'Test', TimeZoneSidKey='America/New_York', LocaleSidKey='en_US',
                          EmailEncodingKey='ISO-8859-1', LanguageLocaleKey='en_US', IsActive = true);
        insert u;
    }
    /* public HttpResponse respond(HttpRequest request){
        String rapidApiHost = 'twinword-text-similarity-v1.p.rapidapi.com';
        String rapidApiKey = '5057c9cd5cmsh4cb024048d6b1d1p174225jsn95e2c534eed4'; //must subscribe for key
        String rapidApiContentType = 'application/x-www-form-urlencoded';
        //Fake Response
        HttpResponse response = new HttpResponse();
        response.setHeader('x-rapidapi-host', rapidApiHost);
        response.setHeader('x-rapidapi-key', rapidApiKey);
        response.setHeader('content-type', rapidApiContentType);
        response.setBody('{"author":"twinword inc.","email":"help@twinword.com","result_code":"200","result_msg":"Success","similarity":0.86882813106215,"value":2463079.7207981,"version":"4.0.0"}');
        response.setStatusCode(200);
        Return response;
    } */

    @isTest
    public static void createMockInterviewPositiveTest() {
        User testUser = [SELECT id FROM User WHERE lastName='stuff']; 
        
        Contact conta = [SELECT id FROM Contact WHERE lastname='stuff'];

        System.runAs(testUser) {
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
        }
    }
    @isTest
    public static void createMockInterviewNegativeTest() {
        User testUser = [SELECT id FROM User WHERE lastName='stuff']; 
        
        Contact conta = [SELECT id FROM Contact WHERE lastname='stuff'];

        System.runAs(testUser) {
            List<String> types = new List<String>{'Apex', 'Visualforce'};
            CreateMockInterviewController.createMockInterview(null, types);
            Integer gotQuestions = [SELECT COUNT() FROM Interview_Question__c WHERE Meeting_md__r.Name = 'Mock interview with Null questions'];
            //AggregateResult numQuestion = gotQuestions[0];
            System.assertNotEquals(null, gotQuestions);
        }
    }
     @isTest
    public static void textSimilarityTest() {
        //Set Mock Callout class
        Test.setMock(HttpCalloutMock.class, new comparePanelAnswersControllerMock());
        //Call Method test
        Decimal response = CreateMockInterviewController.textSimilarity('The hippocampus is a major component of the brains of humans and other vertebrates. It belongs to the limbic system and plays important roles in the consolidation of information from short-term memory to long-term memory and spatial navigation. Humans and other mammals have two hippocampi, one in each side of the brain. The hippocampus is a part of the cerebral cortex; and in primates it is located in the medial temporal lobe, underneath the cortical surface. It contains two main interlocking parts: Ammon\'s horn and the dentate gyrus.',
        'An important part of the brains of humans and other vertebrates is the hippocampus. It\'s part of the limbic system and moves information from short-term to long-term memory. It also helps us move around. Humans and other mammals have two hippocampi, one on each side. The hippocampus is a part of the cerebral cortex; and in primates it is found in the medial temporal lobe, beneathe the cortical surface. It has two main interlocking parts: Ammon\'s horn and the dentate gyrus.');
        //verify response
        // String rapidApiHost = response.getHeader('x-rapidapi-host');
        // String rapidApiKey = response.getHeader('x-rapidapi-key');
        // String rapidApiContentType = response.getHeader('content-type');
        // System.assert(rapidApiHost == 'twinword-text-similarity-v1.p.rapidapi.com');
        // System.assert(rapidApiKey == '5057c9cd5cmsh4cb024048d6b1d1p174225jsn95e2c534eed4');
        // System.assert(rapidApiContentType == 'application/x-www-form-urlencoded');
        // String actualValue = response.getBody();
        // String expectedValue = '{"author":"twinword inc.","email":"help@twinword.com","result_code":"200","result_msg":"Success","similarity":0.86882813106215,"value":2463079.7207981,"version":"4.0.0"}';
        // System.assertEquals(actualValue, expectedValue);
        // System.assertEquals(200, response.getStatusCode());
        Decimal expectedValueRaw = 0.86882813106215;
        Decimal expectedValueFixed = (expectedValueRaw*100).setScale(2);
        System.assertEquals(response, expectedValueFixed);
    } 
}