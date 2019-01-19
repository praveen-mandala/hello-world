public class ExtentionCon {

    Account a = new Account();
    public ExtentionCon(ApexPages.StandardController con){
        
         a = (Account)con.getRecord();
        
    }
    public String getDisplay(){
    
        return 'Hello'+a.Name;
    }
    
}