/*
Description : Controller for Pagination Task
Author: Praveen Goud
Date Of Creation: 14-07-2017
Last Modification: 14-07-2017
Modification History: null
*/
public class PaginationREDOController {
    
    public List<Contact> conList{set;get;}
    public boolean flag{set;get;}
    public Integer totalPages{set;get;}
    public PaginationREDOController() {
        conList = [Select Id,LastName,Phone,Email From Contact ORDER BY LastName limit 10];
        Integer count = [Select count() From Contact];
        if(Math.mod(count,10) == 0)
            totalPages = count/10;
        else
            totalPages = (count/10)+1;
        
    }
    public void getContacts() {
        System.debug('Hello Test');
        Integer off = Integer.ValueOf(ApexPages.currentPage().getParameters().get('off'));
        System.debug(off);
        if(off >= 0) {
            conList = [Select Id,LastName,Phone,Email From Contact ORDER BY LastName limit 10 offset :off];
            flag = false;
        }
        if(conList.size() == 0) {
            flag = true;
        }
     }
}