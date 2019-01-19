/*
 Description : create Task for a Contact
 Author: Praveen Goud
 Date Of Creation: 23-06-2017
 Last Modification: 23-06-2017
 Modification History: null
 */
public class CreateTaskForContact {
  /*
     Description: This method creates a Contact
	 Param : LastName - lastName of Contact
	 return : ContactId
  */ 
  private Id createContact(String LastName) {
    Contact con = new Contact();
    con.LastName = LastName;
    insert con;
    return con.Id;
  }
  /*
     Description: This method creates a Task Related to Contact
	 Param : conName - Name of Contact
	 Param : status - status of Contact
	 Param : subject - subject of Contact
  */
  public void createRelatedTask(String conName , String status, String subject) {
    Task task = new Task();
    task.Status = status;
    task.Subject = subject;
    task.WhoId = createContact(conName);
    insert task;
  }
}