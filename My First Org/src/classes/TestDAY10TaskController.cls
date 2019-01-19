/*
Description : Test class for DAY10TaskController 
Author: Praveen Goud
Date Of Creation: 05-07-2017
Last Modification: 06-07-2017
Modification History: 
*/
@IsTest
public class TestDAY10TaskController {

    @IsTest
    public static void testprepareSearchQuery() {
		DAY10TaskController dAY10TaskController = new DAY10TaskController();
        createContactsUtility();
        dAY10TaskController.conList = null;
        dAY10TaskController.LastName='testLastName';
        dAY10TaskController.Phone='123456';
        dAY10TaskController.Email='test@test.com';
        dAY10TaskController.prepareSearchQuery();
    }
    
    public static void createContactsUtility() {
		List<Contact> conList = new List<Contact>();
        Contact c = new Contact();
        c.LastName = 'testLastName';
        c.Phone = '123456';
        c.Email = 'Test@test.com';
        conList.add(c);
        insert conList;
        ExampleCS__c ex = new ExampleCS__c();
        ex.Name = 'TTT';
        ex.Order__c = 1;
        insert ex;
    }
}