/*
 Description : BootCampDay3
 Author: Praveen Goud
 Date Of Creation: 23-06-2017
 Last Modification: 23-06-2017
 Modification History: null
 */
public class BootCampTask3 {
  Map<Id ,Account> accountMap = new Map<Id ,Account>([Select Id,Owner.Name from Account]);
  Map<Id ,Contact> contactMap = new Map<Id ,Contact>([Select Id,Account.Id from Contact]);
  Map<Id ,Case> caseMap = new Map<Id ,Case>([Select Id,Contact.Id from Case]);
  /*
     Description: This method finds the owner of your Contact
	 Param : conId - Contact Id	
	 return : returns Owner Name of Contact
  */
  public String findOwnerForContact(Id conId) {
    return accountMap.get(contactMap.get(conId).AccountId).Owner.Name;
  }
  /*
     Description: This method finds the owner of your Case
	 Param : caseId - Case Id
     return : returns Owner Name of Case
  */
  public String findOwnerForCase(Id caseId) {
    return accountMap.get(contactMap.get(caseMap.get(caseId).ContactId).AccountId).Owner.Name;
  }
}