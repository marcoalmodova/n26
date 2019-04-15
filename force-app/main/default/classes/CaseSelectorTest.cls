@isTest
public class CaseSelectorTest {

    @isTest
    static void testGetCaseById()
    {
        Product2 p = TestDataFactory.createProducts(1)[0];
        insert p;
        
        Contact c = TestDataFactory.createContacts(1)[0];
        c.Home_Country__c = 'DE';
        c.Product__c = p.Id;
        insert c;
        
        Case ca = TestDataFactory.createCases(1)[0];
        ca.ContactId = c.Id;
        insert ca;
        
        Test.startTest();
        Case caseAux = CaseSelector.getCaseById(ca.Id);
        
        System.assertEquals(caseAux.ContactId, ca.ContactId);
        
        Test.stopTest();
    }
}