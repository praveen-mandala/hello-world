public class TestController {

  
    public Boolean flag{set;get;}
    public List<Account> accList{set;get;}
    public List<Account> getDetails{set;get;}
    public String AccId{set;get;}
    
    public TestController() {
        accList = [Select Name from Account];
    }
    
    public void getdetails() {
        flag=true;
     	getDetails=[Select Name,Rating,Type from Account Where Id=:AccId];   
    }
}