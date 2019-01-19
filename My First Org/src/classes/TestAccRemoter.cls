/*
Description : Test Class for AccRemoter Controller class 
Author: Praveen Goud
Date Of Creation: 03-07-2017
Last Modification: 03-07-2017
Modification History: 
*/
@IsTest
public class TestAccRemoter {
    
    @IsTest
    public static void testgetContacts1() {
        AccRemoter obj = new AccRemoter();
        Contact c = new Contact();
        c.LastName = 'Test1';
        insert c;
        AccRemoter.getContacts1('Test');
    }
}