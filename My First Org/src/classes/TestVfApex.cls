public class TestVfApex {

    List<Contact> con = new list<contact>();
    
    public List<Contact> getCon() {
        con = [Select LastName,Email From Contact Limit 20];
        return con;
    }
    
    public void savein() {
        update con;
    }
}