public inherited sharing class ContactSelector {
    
    public static List<Contact> getContactsToSurvey()
    {
        return [SELECT Id,
               FirstName,
               LastName,
               Language__c,
               Survey_date__c
               FROM Contact
               WHERE Survey_date__c < TODAY
               AND Email != null
               AND Send_email__c = false];
    }
}