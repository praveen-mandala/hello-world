/*
 Description : Test class for RerenderContactsController 
 Author: Praveen Goud
 Date Of Creation: 30-06-2017
 Last Modification: 30-06-2017
 Modification History: 
*/
@IsTest
public class TestRerenderContactsController {
    @IsTest
    public static void testgetContacts(){
        RerenderContactsController obj = new RerenderContactsController();
        Account a = new Account();
        a.Name = 'Test';
        insert a;
        Contact c= new Contact();
        c.AccountId = a.Id;
        c.LastName='Test';
        insert c;
        obj.getContacts();
        obj.getAccountDetails();
        obj.getAccounts();
    }
}