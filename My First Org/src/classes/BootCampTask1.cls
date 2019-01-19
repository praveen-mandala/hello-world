/*
 Description : BootCampDay3
 Author: Praveen Goud
 Date Of Creation: 23-06-2017
 Last Modification: 23-06-2017
 Modification History: null
 */

public class BootCampTask1 {
  /*
     Description: This method will insert the record into Contact object
	 Param : LastName - Name of the Contact
	 Param : Title - Title of the Contact
	 Param : email - Email of the Contact	
  */
  public void createContact(String LastName , String Title , String email) {
    Contact contact = new Contact();
    contact.LastName = LastName;
    contact.Title = Title;
    contact.Email = email;
      try {
        insert contact;
      }
      catch(Exception e){
        System.debug(e.getMessage());
      }
  }
  /*
     Description: This method will insert multiple records into Contact object
	 Param : names - Contact names seperated by comas
	 Param : titles - Contact titles seperated by comas	
  */
  public void createMultipleContacts(String names , String titles) {
    List<String> name = names.split(',');
    List<String> title = Titles.split(',');
    List<Contact> conList = new List<Contact>();
    for(Integer i=0 ; i<name.size() ; i++) {
      Contact contact = new Contact();
      contact.LastName = name[i];
      contact.Title = title[i];
      conList.add(Contact);
    }
    try {
      insert conList;
    }
    catch(Exception e){
      System.debug(e.getMessage());
    }
  }
}