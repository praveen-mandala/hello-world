/*
 Description : BootCampDay3Task
 Author: Praveen Goud
 Date Of Creation: 23-06-2017
 Last Modification: 27-06-2017
 Modification History: null
*/
public class BootCampTask5 {
  /*
     Description: This method will return a Map with AccountId as key and  related Contacts as value record	
	 return : accountAndContactsMap
  */
  public Map<Id , List<Contact>> accountAndRelatedContacts() {
    List<Account> accList = [Select Id From Account];
    List<Contact> conList = [Select Id,AccountId from Contact];
    Map<Id , List<Contact>> accountAndContactsMap = new Map<Id , List<Contact>>();
    for(Account a : accList) {
      List<Contact> conList1 = new List<Contact>();
      for(Contact c : conList) {
        if(a.Id.equals(c.AccountId)) {
          conList1.add(c);
        }
      }
      accountAndContactsMap.put(a.Id, conList1);
    }
    return accountAndContactsMap;
  }
  /*
     Description: This method will return a Map with ContactId as key and  related Cases as value record
	 return : contactAndCasesMap
  */
  public Map<Id , List<Case>> contactAndRelatedCases() {
    List<Contact> conList = [Select Id From Contact];
    List<Case> caseList = [Select Id,ContactId From Case];
    Map<Id , List<Case>> contactAndCasesMap = new Map<Id , List<Case>>();
    for(Contact c : conList) {
      List<Case> caseList1 = new List<Case>();
      for(Case ca : caseList) {
        if(c.Id.equals(ca.ContactId)) {
          caseList1.add(ca);
        }
      }
      contactAndCasesMap.put(c.Id, caseList1);
    }
    return contactAndCasesMap;
  } 
}