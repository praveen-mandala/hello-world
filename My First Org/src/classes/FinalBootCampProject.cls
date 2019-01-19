public class FinalBootCampProject {

    private integer counter=0;  //keeps track of the offset
   private integer list_size=2; //sets the page size or number of rows
   public integer total_size; //used to show user the total size of the list
    public List<EmployeeWrapCls> lstEmpWrap{get;set;}
    public List<EmployeeWrapCls> lstDispEmpWrap{get;set;}
    public integer pfrom=0;
    public integer pto=0;

    public Event__c objEvent{get;set;}
    public FinalBootCampProject() {
        lstEmpWrap = new List<EmployeeWrapCls>();
        lstDispEmpWrap = new List<EmployeeWrapCls>();
        String param = ApexPages.currentPage().getParameters().get('Id');
        objEvent=[Select Id,
                  Name,
                  Company__r.Name,
                  Category__c,
                  Type__c,
                  Start_Date__c,
                  End_Date__c 
                  From 
                  Event__C 
                  Where Id=:param];
            List<Event_Attendees__c> attendeesLst = [Select Name ,Employee__r.Id From Event_Attendees__c Where Event__r.Id = :objEvent.Id];
            List<Id> empIdLst = new List<Id>();
            for(Event_Attendees__c ea : attendeesLst) {
                empIdLst.add(ea.Employee__r.Id);
            }
            Company__c company = [Select Id,
                              (Select Id,
                               Name 
                               From Employees__r) 
                              From Company__c 
                              Where Id=:objEvent.Company__c][0];
            List<Employee__c> employeeLst = [Select Id,Name From Employee__c Where Company__r.Id = :company.Id and Id NOT IN :empIdLst];
        for(Employee__c emp : employeeLst) {
            EmployeeWrapCls wrpObj = new EmployeeWrapCls();
            wrpObj.checkB = false;
            wrpObj.EmpObj = emp;
            lstEmpWrap.add(wrpObj);
        }
        System.debug('lstEmpWrap '+lstEmpWrap);
       pfrom=1;
       pto=list_size;
        total_size = lstEmpWrap.size();
       GetMyEmpList(pfrom,pto);
    }
       
    
    public PageReference Next() { //user clicked next button       
       pfrom=pto+1;
       pto+=list_size;
       GetMyEmpList(pfrom,pto);        
      return null;
   }
   
    public PageReference Previous() { //user clicked previous button
       pto-=list_size;
       pfrom=pto-list_size;
       pfrom+=1;
       GetMyEmpList(pfrom,pto);
       return null;
   }
    
    public void GetMyEmpList(integer fpage,integer toPage)
   {
       lstDispEmpWrap.clear();
       for(integer i=fpage;i<=toPage;i++)
       {           
           lstDispEmpWrap.add(lstEmpWrap.get(i));
       } 
   } 
    
    public Boolean getDisableNext() { //this will disable the next and end buttons
      if (counter + list_size < total_size) return false; else return true;
   }
    
    public Class EmployeeWrapCls {
    	public boolean checkB{get;set;}    
    	public Employee__c EmpObj{get;set;}
    }
    
}