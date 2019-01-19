public class TestPagination {

    public List<Contact> conList{set;get;}
    public Integer offset=0;
    public TestPagination() {
        conList = [Select Id,LastName from Contact Limit 10 offset :offset];
    }
    public void getContacts() {
        system.debug(conList);
        conList = [Select Id,LastName from Contact Limit 10 offset :offset];
    }
}