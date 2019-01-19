public class GetContactsController {
    List<Contact> contactList = new list<contact>();
    
    public List<Contact> getCon() {
        contactList = [Select LastName,Email,LeadSource,AccountId,Level__c From Contact Limit 20];
        return contactList;
    }
    
    public void UpdateAll() {
        update contactList;
    }
}