public inherited sharing class ProductSelector {
    
    public static List<PricebookEntry> getProductsAndOptions(Id productId, String country)
    {
        List<Id> listIds = new List<Id>();
        
        for(Product_Option__c po : getProductOptions(productId))
        {
            listIds.add(po.Product_Option__c);
        }
        
        return [SELECT Id,
                Name,
                UnitPrice,
                CurrencyIsoCode,
                Percent__c,
                Product2Id,
                Product2.Name,
                Product2.Pricing_Method__c,
                Pricebook2.Product__c,
                Pricebook2.Product__r.Name,
                Pricebook2.Country__c
                FROM PricebookEntry
                WHERE (Product2Id = :productId OR Product2Id IN :listIds)
                AND Pricebook2.Country__c = :country
                AND Pricebook2.Product__c = :productId];
    }
    
    public static List<Product_Option__c> getProductOptions(Id productId)
    {
        return [SELECT Product_Option__c FROM Product_Option__c WHERE Parent_Product__c = :productId];
    }
}