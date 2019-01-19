public class ABCDPaginationVFController {

    @RemoteAction
    public static void getContacts(String clickedLink) {
        List<Contact> conList = [Select Id,LastName From Contact Where LastName LIKE :clickedLink];
    }
}