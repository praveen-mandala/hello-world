global class PaginationEventVFController {

    global List<EventsWrapperClass> finaleventWrapperlst = new List<EventsWrapperClass>();
    public List<EventsWrapperClass> eventWrapperlst1{get;set;}
    public Event__c event{get;set;}
    public List<selectOption> options{set;get;}
    
    public PaginationEventVFController() {
        Integer off = Integer.ValueOf(ApexPages.currentPage().getParameters().get('off'));
        EventsWrapperClass eventWrapper = new EventsWrapperClass();
        String id='a0a7F000000cotU';
        eventWrapperlst1 = new List<EventsWrapperClass>();
        event = [Select Id,Name,Company__r.Name,Category__c,Type__c,Start_Date__c,End_Date__c From Event__C Where Id=:Id];
        System.debug('event '+event);
        Company__c company = [Select Id,(Select Id,Name From Employees__r) From Company__c Where Id=:event.Company__c][0];
        List<Employee__c> employeeLst = [Select Id,Name From Employee__c Where Company__r.Id=:company.Id limit 10 offset :off];
        getEmployeesDetails();
        for(Employee__c e:employeeLst) {
            
            EventsWrapperClass ob = new EventsWrapperClass();
            ob.checkedEmp = false;
            ob.employeeName = e.Name;
            ob.employeeId = e.Id;
            eventWrapperlst1.add(ob);
        } 
        System.debug('wrap '+eventWrapperlst1);
    }
    
    public void getEmployeesDetails() {
        options = new List<SelectOption>();
        
        Schema.DescribeFieldResult fieldResult =
            Event_Attendees__c.Participation_Type__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        options.add(new SelectOption('--select--', '--select--'));
        for( Schema.PicklistEntry f : ple)
        {
            options.add(new SelectOption(f.getLabel(), f.getValue()));
        } 
    }
    
    public void createRecords() {
}
}