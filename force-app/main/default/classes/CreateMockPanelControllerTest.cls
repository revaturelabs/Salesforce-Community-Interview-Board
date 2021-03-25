@isTest
public class CreateMockPanelControllerTest {

@isTest
public static void getTypePicklistValuesTest() {
     User testUser = [SELECT id FROM User WHERE lastName='Carlson']; 
     System.debug(testUser);
     Map<String,List<String>> returnedMap = new Map<String,List<String>>();

     System.runAs(testUser) {
     returnedMap = CreateMockPanelController.getTypePicklistValues();
     }

    List<String> salesforceTypes = new List<String>{'Apex', 'Apex Trigger','Apex Testing', 'Visualforce','Aura/Lightning Components', 'Declarative Salesforce', 'SOQL/SOSL', 'HTML/CSS', 'JavaScript'};
    List<String> javaTypes = new List<String>{'Java', 'React', 'Spring', 'Typescript', 'Node.Js', 'JavaScript'};
    List<String> netTypes = new List<String>{'C#', 'C++', 'SQL', 'JavaScript', 'Python', 'C'};
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

@isTest
public static void createMockPanelPositiveTest() {
    List<String> testObject = new List<String>{'Java', 'Apex', 'Visualforce'};
    List<Integer> results = CreateMockPanelController.getNumberOfQuestionType(testObject);
    System.assertEquals(3, results.size());
    System.assertEquals(33, results[0]);
    System.assertEquals(34, results[1]);
    System.assertEquals(33, results[2]);
}

@isTest
public static void createMockPanelNegativeTest() {
    List<String> testObject = new List<String>{'Banana', 'Egg', 'potato'};
    List<Integer> results = CreateMockPanelController.getNumberOfQuestionType(testObject);
    System.assertEquals(3, results.size());
    System.assertEquals(0, results[0]);
    System.assertEquals(0, results[1]);
    System.assertEquals(0, results[2]);
}

@isTest static void createMockPanelNullTest() {
    List<String> testObject = new List<String>();
    List<Integer> results = CreateMockPanelController.getNumberOfQuestionType(testObject);
    System.assertEquals(0, results.size());
}
}