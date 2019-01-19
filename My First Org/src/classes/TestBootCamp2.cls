/*
 Description : Test Class for BootCampDay4Task class
 Author: Praveen Goud
 Date Of Creation: 23-06-2017
 Last Modification: 27-06-2017
 Modification History: null
*/
@IsTest
public class TestBootCamp2 {
  static Account acc = new Account();
  static List<Contact> conList = new List<Contact>();
  @isTest
  public static void TestMeth() {
    getData();
    BootCampDay2.getMap(acc.Id);
    BootCampDay2.method2(acc.Id);
  }
  @TestSetUp
  private static void getData() {
    acc.Name = 'Test';
    acc.ShippingCity = 'Test';
    acc.ShippingCountry = 'Test';
    acc.ShippingState = 'Test';
    insert acc;
    Contact con = new Contact();
    con.AccountId=acc.Id;
    con.LastName = 'Test';
    con.Email = 'Test@test.com';
    con.MailingCity = acc.ShippingCity;
    con.MailingCountry = acc.ShippingCountry;
    con.MailingState ='cvbnm';
    conList.add(con);
    Contact con1 = new Contact();
    con1.LastName = 'Test';
    con1.AccountId=acc.Id;
    con1.MailingCity = acc.ShippingCity;
    con1.MailingCountry = acc.ShippingCountry;
    con1.MailingState =acc.ShippingState;
    conList.add(con1);
    insert conList;
  }
}