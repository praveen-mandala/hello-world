/*
Description : Controller class for Day8PaginationVF 
Author: Praveen Goud
Date Of Creation: 03-07-2017
Last Modification: 03-07-2017
Modification History: 
*/
public class Day8PaginationController {
	public Day8PaginationController(ApexPages.StandardSetController controller) {}
    @RemoteAction
  	  public static List<Contact> getNxtContact(String contactId, Integer offset){
      List<Contact> contactSearchRes = new List<Contact>();
      contactSearchRes = [SELECT Id, FirstName, LastName, Phone, Email FROM Contact 
                         WHERE LastName LIKE :'%'+contactId+'%' LIMIT 10 OFFSET :offset];
      return contactSearchRes;
  }
}