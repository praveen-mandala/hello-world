/*
 Description : Test class for AccountController 
 Author: Praveen Goud
 Date Of Creation: 30-06-2017
 Last Modification: 30-06-2017
 Modification History: 
*/
@IsTest
public class TestAccountController {
	 @IsTest
    public static void testgetAccDetails(){
        AccountController obj = new AccountController();
        Account a = new Account();
        a.Name = 'Test';
        insert a;
        obj.getAccDetails();
        obj.getAccountNames();
        obj.getContacts();
        obj.getAccInfo();
    }
     @IsTest
    public static void testgetAccDetails1(){
        ApexPages.StandardSetController con;
        AccountController obj = new AccountController(con);
        Account a = new Account();
        a.Name = 'Test';
        insert a;
        obj.getAccDetails();
        obj.getAccountNames();
        obj.getContacts();
        obj.getAccInfo();
    }
}