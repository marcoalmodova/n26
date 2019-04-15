public inherited sharing class LimitsHelper {

    public static Integer getDailyWorkflowEmailsLimit()
    {  
        return OrgLimits.getMap().get('DailyWorkflowEmails').getLimit() - OrgLimits.getMap().get('DailyWorkflowEmails').getValue();
    }
}