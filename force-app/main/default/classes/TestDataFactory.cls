@isTest
public class TestDataFactory {
    
    public static List<Contact> createContacts(Integer qty)
    {
        List<Contact> listContact = new List<Contact>();
        
        for(Integer i = 0; i<qty; i++)
        {
            Contact c = new Contact();
            
            c.FirstName = 'FirstName' + i;
            c.LastName = 'LastName' + i ;
            c.Email = i+ 'email@email.com';
            
            listContact.add(c);
        }
        
        
        return listContact;
    }
    
    public static List<Case> createCases(Integer qty)
    {
        List<Case> listCase = new List<Case>();
        
        for(Integer i = 0; i<qty; i++)
        {
            Case c = new Case();
            
            c.Status = 'New';
            c.Origin = 'Phone';
            
            listCase.add(c);
        }
        
        
        return listCase;
    } 
    
    public static List<Product2> createProducts(Integer qty)
    {
        List<Product2> listProducts = new List<Product2>();
        
        for(Integer i = 0; i<qty; i++)
        {
            Product2 p = new Product2();
            
            p.Name = 'Product'+i;
            p.isActive = true;
            
            listProducts.add(p);
        }
        
        
        return listProducts;
    }
    
    public static List<PriceBook2> createPricebooks(Integer qty, Product2 product, String country)
    {
        List<PriceBook2> listPBs = new List<PriceBook2>();
        
        for(Integer i = 0; i<qty; i++)
        {
            Pricebook2 p = new Pricebook2();
            p.Name = 'PB'+i;
            p.IsActive = true;
            p.Product__c = product.Id;
            p.Country__c = country;
            listPBs.add(p);
        }
        
        return listPBs;
    }
    
    public static List<PricebookEntry> createPBEs(List<Pricebook2> listPBs, List<Product2> listProducts)
    {
        List<PricebookEntry> listPBEs = new List<PricebookEntry>();
        Id pricebookId = Test.getStandardPricebookId();
        
        for(Product2 p : listProducts)
        {
            PricebookEntry pbe = new PricebookEntry(
                Pricebook2Id = pricebookId, Product2Id = p.Id,
                UnitPrice = 10000, IsActive = true);
            
            listPBEs.add(pbe);
        }
        
        insert listPBEs;
        
        listPBEs = new List<PricebookEntry>();
        
        for(Pricebook2 pb : listPBs)
        {
            for(Product2 p : listProducts)
            {
                PricebookEntry pbe = new PricebookEntry(
                    Pricebook2Id = pb.Id, Product2Id = p.Id,
                    UnitPrice = 10000, IsActive = true);
                
                listPBEs.add(pbe);
            }
        }
        
        return listPBEs;
    }
}