public class ContactSearch {

    public static List<Contact> searchForContacts(String a, String b){

        List<Contact> conList = new List<Contact>();
        conList = [SELECT FirstName,LastName FROM Contact WHERE (LastName=:a AND MailingPostalCode=:b)];
    
        return conList;
    }
}