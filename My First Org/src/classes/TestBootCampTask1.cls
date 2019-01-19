/*
 Description : Test Class for BootCampDay3Task classes.
 Author: Praveen Goud
 Date Of Creation: 23-06-2017
 Last Modification: 27-06-2017
 Modification History: null
*/
@IsTest
public class TestBootCampTask1 {
  public static TestMethod void abc() {
    Account a = new Account();
    a.Name = 'Test';
    insert a;
    Contact c2 = new Contact();
    c2.AccountId = a.Id;
    c2.LastName = 'Test';
    insert c2;
    BootCampTask1 obj = new BootCampTask1();
    BootCampTask2 obj2 = new BootCampTask2();
    BootCampTask3 obj3 = new BootCampTask3();
    obj.createContact('TestABC','TestABC' , 'email@email.com');
    obj.createMultipleContacts('TestABC,TestXYZ','TestABC,TESTXYZ');
    obj2.createRelatedContact('Test', 'TestAcc');
    obj3.findOwnerForContact(c2.Id); 
  }
  @IsTest
  public static void Test2() {
    Account a = new Account();
    a.Name = 'Test';
    insert a;
    Contact c2 = new Contact();
    c2.AccountId = a.Id;
    c2.LastName = 'Test';
    insert c2;
    Case c1 = new Case();
    c1.ContactId = c2.Id;
    c1.Subject = 'Test';
    BootCampTask3 obj3 = new BootCampTask3();
    obj3.findOwnerForCase(c1.Id);
  }
  @IsTest
  public static void Test3() {
    CreateTaskForContact obj4 = new CreateTaskForContact();
    obj4.createRelatedTask('Testasas', 'High', 'sdsd');   
  }
  @IsTest
  public static void Test4() {
    BootCampTask5 obj5 = new BootCampTask5();
    Contact c3 = new Contact();
    c3.LastName = 'Test';
    insert c3;
    Case c1 = new Case();
    c1.ContactId = c3.Id;
    insert c1;
    obj5.contactAndRelatedCases();
  } 
  @IsTest
  public static void Test5() {
    BootCampTask5 obj5 = new BootCampTask5();
    Account a = new Account();
    a.Name = 'Test';
    insert a;
    Contact c2 = new Contact();
    c2.AccountId = a.Id;
    c2.LastName = 'Test';
    insert c2;
    obj5.accountAndRelatedContacts();
  } 
}