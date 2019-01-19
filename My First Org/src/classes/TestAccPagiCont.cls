public class TestAccPagiCont {

    public List <Employee__c> empList{get;set;}
    public List <WrapperClass> wrapperRecordList{get;set;}
    Map<Id, WrapperClass> mapHoldingSelectedRecords{get;set;}
    public ApexPages.StandardSetController setCon{get;set;}
    
	    
    public TestAccPagiCont() {
        System.debug('Constructor');
        empList = [SELECT Id,Name FROM Employee__c];
        setCon = new ApexPages.StandardSetController(empList);
        setCon.setPageSize(2);
        mapHoldingSelectedRecords = new Map<Id, WrapperClass>();
        init();
    }
    public void init() {
        
        wrapperRecordList = new List<WrapperClass>();
        for (Employee__c emp : (List<Employee__c>)setCon.getRecords()) {
            if(mapHoldingSelectedRecords != null && mapHoldingSelectedRecords.containsKey(emp.id)){
                wrapperRecordList.add(mapHoldingSelectedRecords.get(emp.id));
                
            }
            else{
                wrapperRecordList.add(new WrapperClass(emp, false));
            }
            
        }
        System.debug('wrapperRecordList '+wrapperRecordList.size());
        System.debug('wrapperRecordList '+wrapperRecordList);
        System.debug('mapHoldingSelectedRecords '+mapHoldingSelectedRecords);
    }
    public Boolean hasNext {
        get {
            return setCon.getHasNext();
        }
        set;
    }
    
    /** indicates whether there are more records before the current page set.*/
    public Boolean hasPrevious {
        get {
            return setCon.getHasPrevious();
        }
        set;
    }
    
    public void previous() {
        updateSearchItemsMap();
        setCon.previous();
        init();
    }
    public void next() {
        updateSearchItemsMap();
        setCon.next();
        init();
    }
     public void first() {
        updateSearchItemsMap();
        setCon.first();
        init();
    }
    
    /** returns the last page of the page set*/
    public void last() {
        updateSearchItemsMap();
        setCon.last();
        init();
    }
    public Integer pageNumber {
        get {
            return setCon.getPageNumber();
        }
        set;
    }
     Public Integer getTotalPages(){
        Decimal totalSize = setCon.getResultSize();
        Decimal pageSize = setCon.getPageSize();
        Decimal pages = totalSize/pageSize;
        return (Integer)pages.round(System.RoundingMode.CEILING);
    }
    
    private void updateSearchItemsMap() {
        for(WrapperClass wrp : wrapperRecordList){
            if(wrp.isSelected){
                mapHoldingSelectedRecords.put(wrp.empRecord.id, wrp);
            }
            if(wrp.isSelected == false && mapHoldingSelectedRecords.containsKey(wrp.empRecord.id)){
                mapHoldingSelectedRecords.remove(wrp.empRecord.id);
            }
        }
    }
    
    //wrapper class being used for checkbox showing.
    public class WrapperClass {
        public Boolean isSelected {get;set;}
        public Employee__c empRecord {get;set;}
        public WrapperClass(Employee__c empRecord, Boolean isSelected) {
            this.empRecord = empRecord;
            this.isSelected = isSelected;
        }
    }
    
    
}