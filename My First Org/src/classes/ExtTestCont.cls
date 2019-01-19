public class ExtTestCont {

    public List<Account> accList {get;set;}

    Account acc = new Account();
    public ExtTestCont(ApexPages.StandardController con) {

        //acc = (Account)con.getRecord();accList.add(acc);
        
    }
    
    public void getInsert() {
       accList = [Select Id,Name From Account Where Name Like '%Test%'];
    }
}