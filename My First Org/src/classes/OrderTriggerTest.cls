@isTest
public class OrderTriggerTest {
    
    public static testmethod void  ValidateOrderTrigger()
    {
        Opportunity optyTest = new opportunity(name='TestOpty',closedate = system.today().addDays(10),stagename = 'Proposal');
        Insert OptyTest;
        OptyTest.StageName = 'Closed Won';
        Test.startTest();
        Update OptyTest;
        Test.setMock(HttpCalloutMock.class, new GOPMockClass());
        Test.stopTest();
    }
}