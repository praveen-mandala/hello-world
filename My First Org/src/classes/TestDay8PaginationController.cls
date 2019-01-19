/*
Description : Test class for Day8PaginationController
Author: Praveen Goud
Date Of Creation: 03-07-2017
Last Modification: 03-07-2017
Modification History: 
*/
@IsTest
public class TestDay8PaginationController {
	@IsTest
    public static void testgetNxtContact() {
        ApexPages.StandardSetController controller = null;
        Day8PaginationController obj = new Day8PaginationController(controller);
		Contact c = new Contact();
        c.LastName = 'Test';
        insert c;
        Day8PaginationController.getNxtContact(c.LastName, 0);
    }
}