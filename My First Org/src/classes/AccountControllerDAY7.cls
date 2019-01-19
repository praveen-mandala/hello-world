/*
 Description : Controller class for Day7Task1 
 Author: Praveen Goud
 Date Of Creation: 18-07-2017
 Last Modification: 18-07-2017
 Modification History: 
*/
public class AccountControllerDAY7 {
	
	//Testing Hello World
    
  //'AccountControllerDAY7.AccountControllerDAY7(ApexPages.StandardController controller)'
      
      public AccountControllerDAY7(ApexPages.StandardController controller) {
          System.debug('test '+ApexPages.currentPage().getParameters().get('id'));
      }      
  public Boolean flag {get;set;}
  public string selectedAccId {get;set;}
  public List<contact> contactDetails{set;get;}
  //This method gets the list of Accounts 
  public List<SelectOption> getAccountNames() {
      List<SelectOption> accOptions= new List<SelectOption>();
      accOptions.add( new SelectOption('','--Select--'));
      for( Account acc : [select Id,name from Account ] ) {
          accOptions.add( new SelectOption(acc.Id,acc.name));
      }
      return accOptions;
  }
  //This method gets the contacts of selected Account
  public void getContacts(){
      flag = false;
        contactDetails = [SELECT Name FROM Contact WHERE Account.Id = :selectedAccId ];
      if(contactDetails.size()>0)
          flag = true;
  }
}