@isTest
public class ContactSelectorTest {

    @isTest
    static void testGetContactsSurvey()
    {
        Contact c = TestDataFactory.createContacts(1)[0];
        c.Survey_Date__c = System.today() - 1;
        insert c;
        
        Test.startTest();
        List<Contact> listContacts = ContactSelector.getContactsToSurvey();
        
        System.assertEquals(listContacts.size(), 1);
        
        Test.stopTest();
    }
}