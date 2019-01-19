public class ChangeAccStatus {

    public List<Account> accList = [Select Id,Name,Phone,Status__c From Account LIMIT 50];
    
    public void accMeth() {
        for(Account acc : accList) {
            if(acc.Phone == '' || acc.Phone == null) {
                acc.Status__c = 'Active';
            }
            else
                acc.Status__c = 'Completed';
        }
        update accList;
    }
}