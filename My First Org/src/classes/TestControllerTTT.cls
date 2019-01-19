/*
 Description : Test class for ControllerTTT 
 Author: Praveen Goud
 Date Of Creation: 30-06-2017
 Last Modification: 30-06-2017
 Modification History: 
*/
@IsTest
public class TestControllerTTT {
  @IsTest
    public static void  testgetDetails() {
        Account a = new Account();
        a.Name = 'Test';
        insert a;
        ApexPages.StandardSetController con;
      	ControllerTTT obj = new ControllerTTT(con);
        obj.param=a.id;
        obj.getDetails();
	 }    
}