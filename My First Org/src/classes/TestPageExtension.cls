public class TestPageExtension {
	public List<Account> lstAccount {get;set;}
    public string errorMessage;
    public TestPageExtension(ApexPages.StandardController con){
     
        
 	}
    public void showAccount(){
        try{
         lstAccount = new List<Account>([select Id, Name, Phone from Account where Name like '%test%']);   
        }catch(System.Exception ex) {
        	errorMessage = ex.getMessage();
            System.debug('Error Message Is : '+errorMessage);
    	}
    }
}