global with sharing class ApxJRemoteCls {
    public String accountName { get; set; }
	public static List<Contact> AContact { get; set; }
    public static List<Account> AAccount { get; set; }
	public ApxJRemoteCls() { } // empty constructor
    public string AccId {get;set;}
    
    @RemoteAction
	global static List<Contact> getAccount(String accountName) 
	{
    	AContact = [SELECT Id, LastName from contact where Account.Id = :accountName];
    	return AContact;
	}
    
    @RemoteAction
	global static List<Account> getPick(String cName) 
	{
    	AAccount = [SELECT Id,Name from Account Limit 8];
    	return AAccount;
	}
    
    public List<SelectOption> getAccountNames() {
      List<SelectOption> accOptions= new List<SelectOption>();
      accOptions.add( new SelectOption('','--Select--'));
      for( Account acc : [select Id,name from Account ] ) {
          accOptions.add( new SelectOption(acc.Id,acc.name));
      }
      return accOptions;
  }

}