public with sharing class OpportunitiesPaginationController{
    Public Integer size{get;set;} 
    Public Integer noOfRecords{get; set;} 
    public List<SelectOption> paginationSizeOptions{get;set;}
    public List<Employee__c> empList;  
    public List<TestWpr> wprLst{set;get;}
    public ApexPages.StandardSetController setCon{get;set;}
    
    public OpportunitiesPaginationController() {
        wprLst = new List<TestWpr>();
        empList = [Select Id,Name From Employee__c];
        this.setCon = new ApexPages.StandardSetController(empList);
        this.setCon.setPageSize(50);
    }
    
    public List<TestWpr> getRecords() {
        wprLst = new List<TestWpr>();
        for(Employee__c em : (List < Employee__c > ) setCon.getRecords()) {
             TestWpr tobj1 = new TestWpr();
            tobj1.checkkk = false;
            tobj1.obj = em;
            wprLst.add(tobj1);
        }
        return wprLst;
        
        
    }
    

    public class TestWpr {
        public Boolean checkkk{get;set;}
        public Employee__c obj{get;set;}
    }
}