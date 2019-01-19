public with sharing class TestPageContrl {
    
    private integer counter=0;  //keeps track of the offset
   private integer list_size=5; //sets the page size or number of rows
   public integer total_size; //used to show user the total size of the list
    public List<AccountWrapCls> lstAcWrap{get;set;}
    public List<AccountWrapCls> lstDisAcWrap{get;set;}
    public integer pfrom=0;
    public integer pto=0;

   public TestPageContrl() {
       List<Account> lstAc=[select Id, Name, AccountNumber from Account order by Name];
       lstAcWrap=new List<AccountWrapCls>();
       lstDisAcWrap=new List<AccountWrapCls>();
       For(Account a:lstAc)
       {
           AccountWrapCls objAc=new AccountWrapCls();
           objAc.chkAc=false;
           objAc.AcId=a.Id;
           objAc.AcName=a.Name;
           lstAcWrap.add(objAc);
       }
       pfrom=1;
       pto=list_size;
       GetMyAcList(pfrom,pto);
   total_size = [select count() from Account]; //set the total size in the constructor
   }

   public Account[] getAccounts() {
      try {
         Account[] accounts = [select Id, Name, AccountNumber from Account order by Name limit :list_size offset :counter];          		

         return accounts;
      } catch (QueryException e) {
         ApexPages.addMessages(e);   
         return null;
      }
   }

   public PageReference Beginning() { //user clicked beginning
      counter = 0;
      return null;
   }

   public PageReference Previous() { //user clicked previous button
       pto-=list_size;
       pfrom=pto-list_size;
       pfrom+=1;
       GetMyAcList(pfrom,pto);
       return null;
   }

   public PageReference Next() { //user clicked next button       
       pfrom=pto+1;
       pto+=list_size;
       GetMyAcList(pfrom,pto);        
      return null;
   }
    
   public void GetMyAcList(integer fpage,integer toPage)
   {
       lstDisAcWrap.clear();
       for(integer i=fpage;i<=toPage;i++)
       {           
           lstDisAcWrap.add(lstAcWrap.get(i));
       } 
   }

   public PageReference End() { //user clicked end
      counter = total_size - math.mod(total_size, list_size);
      return null;
   }

   public Boolean getDisablePrevious() { 
      //this will disable the previous and beginning buttons
      //if (counter>0) return false; else return true;
      return true;
   }

   public Boolean getDisableNext() { //this will disable the next and end buttons
      if (counter + list_size < total_size) return false; else return true;
   }

   public Integer getTotal_size() {
      return total_size;
   }

   public Integer getPageNumber() {
      return counter/list_size + 1;
   }

   public Integer getTotalPages() {
      if (math.mod(total_size, list_size) > 0) {
         return total_size/list_size + 1;
      } else {
         return (total_size/list_size);
      }
   }


public class AccountWrapCls {
    
    public boolean chkAc{get;set;}    
    public string AcId{get;set;}
    public string AcName{get;set;}

}
}