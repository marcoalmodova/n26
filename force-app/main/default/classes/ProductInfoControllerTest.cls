@isTest
public class ProductInfoControllerTest {
	@isTest
    static void testgetProductInfo()
    {
        Product2 p = TestDataFactory.createProducts(1)[0];
        insert p;
        
        Contact c = TestDataFactory.createContacts(1)[0];
        c.Home_Country__c = 'DE';
        c.Product__c = p.Id;
        insert c;
        
        PriceBook2 pb = TestDataFactory.createPricebooks(1, p, 'DE')[0];
        insert pb;
        
        PricebookEntry pbe = TestDataFactory.createPBEs(new List<Pricebook2>{pb}, new List<Product2>{p})[0];
        insert pbe;
        
        Case ca = TestDataFactory.createCases(1)[0];
        ca.ContactId = c.Id;
        insert ca;
        
        Test.startTest();
        List<PricebookEntry> listPBEs = ProductInfoController.getProductInfo(ca.Id);
        
        System.assertEquals(listPBEs.size(), 1);
        
        Test.stopTest();
    }
}