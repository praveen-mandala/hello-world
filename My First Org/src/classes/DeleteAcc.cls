public class DeleteAcc {

    public static void deleteAccounts() {
    
        List<Account> accList = [SELECT Id From Account];
      
        for(Account acc : accList) {
            
        }
        
    }
}