/*
 Description : Test class for AccountControllerDAY7 
 Author: Praveen Goud
 Date Of Creation: 18-07-2017
 Last Modification: 18-07-2017
 Modification History: 
*/
@IsTest
public class TestAccountControllerDAY7 {

    @IsTest
    public static void testGetContacts() {
        Account acc1 =getAccount();
        AccountControllerDAY7 accountControllerDAY7 = new AccountControllerDAY7();
        accountControllerDAY7.selectedAccId = acc1.Id;
        accountControllerDAY7.getAccountNames();
        accountControllerDAY7.getContacts();
        
    }
    public static Account getAccount() {
        Account acc = new Account();
        acc.Name = 'Test';
        insert acc;
        return acc;
    }
}