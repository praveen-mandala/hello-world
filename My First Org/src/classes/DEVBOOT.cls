public class DEVBOOT {

    
    
    public List<Employee__c> employeeLst{set;get;}
    public List<selectOption> options{set;get;}
    public Event__c event{get;set;}
    
    
    public String SelectedHost{set;get;}
    public Id id;
    
    public DEVBOOT(ApexPages.StandardSetController controller) {
     }

    public DEVBOOT() {
        id = ApexPages.currentPage().getParameters().get('Id'); 
        event = [Select Id,Name,Company__r.Name,Category__c,Type__c,Start_Date__c,End_Date__c From Event__C Where Id=:Id];
        Company__c company = [Select Id,(Select Id,Name From Employees__r) From Company__c Where Id=:event.Company__c][0];
        employeeLst = company.Employees__r;
        
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
    public void getEmployees() {
        
    }
}