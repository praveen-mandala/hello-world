/*
Description : Test Class for Day8Controller Controller class 
Author: Praveen Goud
Date Of Creation: 03-07-2017
Last Modification: 03-07-2017
Modification History: 
*/
@IsTest
public class TestDay8Controller {
	@IsTest
    public static void testgetContactNames() {
        Day8Controller obj = new Day8Controller();
        Contact c = new Contact();
        c.LastName = 'Test';
        insert c;
        Task t = new Task();
        t.Subject='TestSub';
        t.WhoId=c.Id;
        t.Status='TestStatus';
        insert t;
        Day8Controller.getContactNames();
        Day8Controller.getContactTasks(c.Id);
    }
}