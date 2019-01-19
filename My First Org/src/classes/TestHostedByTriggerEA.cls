@IsTest
public class TestHostedByTriggerEA {

    //@IsTest
    public static void testHostedBy() {
		AssignEmployeesUtility objAssign = new AssignEmployeesUtility();
        Event_Attendees__c eAobj = new Event_Attendees__c();
        eAObj.Event__c = objAssign.createEventUtility().Id;
        eAObj.Employee__c = objAssign.createEmployeeUtility().Id;
        eAObj.Participation_Type__c = 'Host';
        insert eAObj;
    }
}