/*
 Description : Get the list of Accounts and Account details Information 
 Author: Praveen Goud
 Date Of Creation: 30-06-2017
 Last Modification: 30-06-2017
 Modification History: 
*/
public class AccountController {
  public List<account> lstAccounts{set;get;}
  public List<account> accountdetails{set;get;}
  public Boolean flag {get;set;}
  public string selectedAccId {get;set;}
  public List<contact> contactDetails{set;get;}
  public ApexPages.StandardSetController stdCntrlr {get; set;} 
  public string AccId {get;set;}
  public List<account> accountInfo{set;get;}
  public AccountController(ApexPages.StandardSetController controller){
    lstAccounts = [SELECT Id, Name, AccountNumber, Site, Phone, AccountSource, AnnualRevenue, 
                      Industry, Fax, Rating FROM Account];
      stdCntrlr = controller;
  }
  public AccountController(){
    lstAccounts = [SELECT Id, Name, AccountNumber, Site, Phone, AccountSource, AnnualRevenue, 
                      Industry, Fax, Rating FROM Account];
  }
  public void getAccDetails(){
    flag = true;
    String AccountId = ApexPages.currentPage().getParameters().get('AccountId');
    accountdetails = [SELECT Id, Name, AccountNumber, Site, Phone, AccountSource, AnnualRevenue, 
                      Industry, Fax, Rating FROM Account WHERE Id = :AccountId];
  }
  public List<SelectOption> getAccountNames() {
      List<SelectOption> accOptions= new List<SelectOption>();
      accOptions.add( new SelectOption('','--Select--'));
      for( Account acc : [select Id,name from Account ] ) {
          accOptions.add( new SelectOption(acc.Id,acc.name));
      }
      return accOptions;
  }
  public void getContacts(){
        contactDetails = [SELECT Name FROM Contact WHERE Account.Id = :selectedAccId ];
  }
  public void getAccInfo(){
      System.debug('Selected Account Id is : '+AccId);
        accountInfo = [SELECT Id, Name, AccountNumber, Site, Phone, AccountSource, AnnualRevenue, 
                      Industry, Fax, Rating FROM Account WHERE Id = :AccId];
  }
}