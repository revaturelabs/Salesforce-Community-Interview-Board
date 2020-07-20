@isTest
public class AssociateControllerTest {
	
    @testSetup
    static void setup() {
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
    
    @isTest
    public static void multipleSuccess() {
        List<Contact> returnedAssociates = AssociateController.AssociateSearch('Associate');
        System.assertEquals(200, returnedAssociates.size());
    }
    
    @isTest
    public static void multipleFail() {
        List<Contact> returnedAssociates = AssociateController.AssociateSearch('Trainer');
        System.assertEquals(0, returnedAssociates.size());
    }
    
}