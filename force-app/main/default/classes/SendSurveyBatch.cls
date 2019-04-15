public with sharing class SendSurveyBatch implements Database.Batchable<Contact>, Schedulable {
    
    public Integer batchSize = 200;
    
    public SendSurveyBatch(){}
    
    public SendSurveyBatch(Integer batchSize)
    {
        this.batchSize = batchSize;
    }
    
    public void execute(SchedulableContext context)
    {
        Database.executeBatch(this, batchSize);
    }
    
    public List<Contact> start(Database.BatchableContext BC)
    {
        return ContactSelector.getContactsToSurvey();
    }
    
    public void execute(Database.BatchableContext BC, List<Contact> scope)
    {
        List<Contact> contactsToUpdate = new List<Contact>();
        Integer dailyWorkflowEmailLimit = LimitsHelper.getDailyWorkflowEmailsLimit();
        Integer availableSize = dailyWorkflowEmailLimit >= scope.size() ? scope.size() : dailyWorkflowEmailLimit;
        
        //all sending will be done by process builder because DailyWorkflowEmails has a greater limit than apex sendEmail
        for(Integer i=0; i<availableSize; i++)
        {
            scope[i].Send_email__c = true;
            contactsToUpdate.add(scope[i]);
        }
        
        if(contactsToUpdate.size()>0)
        {
            //TO-DO: escape validations and triggers, if necessary
            List<Database.SaveResult> listSR = database.update(contactsToUpdate, false);
            
            for(Database.SaveResult sr : listSR)
            {
                if(!sr.isSuccess())
                {
                    //log errors
                    for(Database.Error err : sr.getErrors()) 
                    {
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    }
                }
            }
        }
        
    }
    
    public void finish(Database.BatchableContext BC)
    {
        
    }
}