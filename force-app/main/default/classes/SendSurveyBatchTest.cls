@isTest
public class SendSurveyBatchTest {
    
    @isTest
    static void testBatch()
    {
        String CRON_EXP = '0 0 0 15 3 ? 2022';
        
        Contact c = TestDataFactory.createContacts(1)[0];
        c.Survey_Date__c = system.today() - 1;
        insert c;
        
        Test.startTest();
        String jobId = System.schedule('ScheduledSendSurveys',
                                       CRON_EXP, 
                                       new SendSurveyBatch(1));
        Test.stopTest();
    }
}