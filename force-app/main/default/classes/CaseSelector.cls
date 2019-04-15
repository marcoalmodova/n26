public inherited sharing class CaseSelector {

    public static Case getCaseById(Id caseId)
    {
        return [SELECT
               Id,
               ContactId,
               Contact.Product__c,
               Contact.Home_Country__c
               FROM Case
               WHERE Id = :caseId];
    }
}