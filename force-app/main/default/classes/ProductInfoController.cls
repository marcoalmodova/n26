public with sharing class ProductInfoController {
    
    @AuraEnabled
	public static List<PricebookEntry> getProductInfo(Id caseId)
    {
        Case c = CaseSelector.getCaseById(caseId);

        if(c.ContactId != null && c.Contact.Product__c != null && !String.isBlank(c.Contact.Home_Country__c))
        {
            return ProductSelector.getProductsAndOptions(c.Contact.Product__c, c.Contact.Home_Country__c);
        }
        else
        {
            return null;
        }
    }
}