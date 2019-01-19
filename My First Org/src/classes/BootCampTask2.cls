/*
 Description : BootCampDay3Task
 Author: Praveen Goud
 Date Of Creation: 23-06-2017
 Last Modification: 23-06-2017
 Modification History: null
 */
public class BootCampTask2 {
  /*
     Description: This method will create a Account record
	 Param : name - Name of the Account
	 return : AccountId
  */
  public String createAccount(String name) {
    Account acc = new Account();
    acc.Name = name;
    try{
      insert acc;
    }
    catch(Exception e) {
      e.getMessage();
    }
    return acc.Id;
  }
  /*
     Description: This method will create a contact record related to Account
	 Param : LastName - LastName of the Contact
	 Param : accountName - Name of the Account
	 return : ContactId
  */
  public String createRelatedContact(String LastName , String accountName) {
    Contact con = new Contact();
    con.AccountId = createAccount(accountName);
    con.LastName = LastName;
    try{
      insert con;
    }
    catch(Exception e) {
      e.getMessage();
    }
    return con.Id;
  } 
}