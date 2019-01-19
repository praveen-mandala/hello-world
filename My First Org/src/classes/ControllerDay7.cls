/*
 Description : Controller class for Day7Task2 
 Author: Praveen Goud
 Date Of Creation: 30-06-2017
 Last Modification: 30-06-2017
 Modification History: 
*/
public class ControllerDay7 {

    public List<Account> accountLst{get;set;}
    public String selectedAcc{get;set;}
    public Boolean flag{get;set;}
    public ControllerDay7() {
   
    }
    public ControllerDay7(ApexPages.StandardSetController controller){
    
    }
    //This method gets the details of selected Account
    public void getAccDetails() {
        flag = true;
        accountLst = [Select Id,Name From Account Where Id=:selectedAcc];
    }
}