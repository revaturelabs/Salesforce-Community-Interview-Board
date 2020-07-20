@IsTest
public class AssociateInfoControllerTest {
    @TestSetup
    static void setup(){
        Id recordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Associate').getRecordTypeId();
        List<Contact> testAssociates = new List<Contact>();
        for(Integer i = 0; i < 200; i++){
            Contact newAssociate = new Contact(FirstName = 'Associate ' + i,
                                               LastName = 'Test',
                                               RecordTypeId = recordTypeId);
            testAssociates.add(newAssociate);
        }
        insert testAssociates;
    }
    
    @IsTest
    public static void test() {
        Contact retrieved = AssociateInfoController.getContact();
        System.assert(retrieved.Name.contains('Associate'));
    }
}