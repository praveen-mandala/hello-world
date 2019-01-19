@IsTest
public class TestBootCampDay2 {
    
    public static TestMethod void testGetMap() {
        Contact c = new Contact();
        c.LastName = 'TestMethod';
        c.AccountId = '0017F000005totq';
        c.Email = 'prvngoud2@gmail.com';
        insert c;
    	BootCampDay2.getMap('0017F000005totq');
    }    
    public static TestMethod void testMethod2() {
        Account a = new Account();
        a.Name = 'Test';
        a.ShippingCity ='AA';
        a.ShippingCountry = 'AA';
        a.ShippingState = 'AA';
        insert a;
        List<Contact> conList = new List<Contact>();
        Contact c = new Contact();
        c.LastName = 'TestMethod';
        c.AccountId = a.Id;
        c.Email = 'prvngoud2@gmail.com';
        conList.add(c);
        Contact c1 = new Contact();
        c1.LastName = 'TestMethod';
        c1.AccountId = a.Id;
        c1.Email = 'prvngoud2@gmail.com';
        c1.MailingCity=a.ShippingCity;
        c1.MailingCountry = a.ShippingCountry;
        c1.MailingStreet = a.ShippingStreet;
        conList.add(c1);
        insert conList;
       	BootCampDay2.method2(a.Id); 
    }
    
   /* public static TestMethod void testMethod3() {
        Account a = new Account();
        a.Name = 'Test';
        a.ShippingCity ='AA';
        a.ShippingCountry = 'AA';
        insert a;
        
    }*/

}