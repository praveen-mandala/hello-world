/*
 Description : Get the list of Client and related details 
 Author: Praveen Goud
 Date Of Creation: 03-07-2017
 Last Modification: 03-07-2017
 Modification History: 
*/
public class Day8Controller {
  public static List<Contact> lstContacts = new List<Contact>();
  public Day8Controller(){
    lstContacts = [SELECT Id, LastName FROM Contact];
  }
  @RemoteAction
  public static List<Contact> getContactNames() {
    lstContacts = [SELECT Id, LastName FROM Contact];
    return lstContacts;
  }
  @RemoteAction
  public static List<Task> getContactTasks(string conId){ 
      List<Task> conTasks = [select Id,Subject from Task Where Who.Id = :conId];
      return conTasks;
  }
}