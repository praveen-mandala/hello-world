public class RenderedController {
    public List<Account> accountdata {set;get;}
    public List<Account> accountDetailsObj {set;get;}
    public boolean flag {set;get;}
      public boolean flagdetails {set;get;}
    public String param1 {set;get;}
    
    public void accounts(){
        flag=true;
       accountdata= [select Name,id from Account limit 1];
    }
     public void accountsDetails(){
        flagdetails=true;
     // String  param1= ApexPages.currentPage().getParameters().get('account.name');
         System.debug(param1);
       accountDetailsObj= [select name from Account where id=:param1];
    }
    

}