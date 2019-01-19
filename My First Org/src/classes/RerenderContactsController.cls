/*
 Description : Get the list of Accounts and Account details Information 
 Author: Praveen Goud
 Date Of Creation: 30-06-2017
 Last Modification: 30-06-2017
 Modification History: 
*/
public class RerenderContactsController {
    public List<Contact> conList{set;get;}
    public List<Account> accList{set;get;}
    public List<Account> accList1{set;get;}
    public String option{set;get;}
    public String param{set;get;}
    public List<SelectOption> getAccounts() {
        List<SelectOption> acc = new List<SelectOption>();
        acc.add(new SelectOption('','--Select--'));
        accList1 = [Select Id,Name From Account];
        for(Account a : accList1) {
            acc.add(new SelectOption(a.Id,a.Name));
        }
        return acc;
    }
    public RerenderContactsController(ApexPages.StandardSetController controller) {}
    public RerenderContactsController() {}
    public void getContacts() {
        System.debug(option);
        conList = [Select Id,LastName,Email,Phone From Contact Where Account.ID=:option];
    }
    public void getAccountDetails() {
        accList=[Select Id,Name From Account where Id=:param ];
        System.debug('acc '+accList);
    }
}