public class TESTDATE {

    public Integer selectedYear{get;set;}
    public Integer count{get;set;}
    public List<SelectOption> options1{get;set;}
    
    public TESTDATE() {
        options1 = new List<SelectOption>();
        options1.add(new SelectOption('select','select'));
        Integer d = System.today().year();
        for(Integer i=d-5 ;i<d+5 ;i++){
            options1.add(new SelectOption(i+'',i+'')); 
        }
    }
    
    public void selectedYearMeth() {
        system.debug('selectedYear '+selectedYear);
        String Id = ApexPages.CurrentPage().getParameters().get('id');
        count = [Select Count() From Event__c Where CALENDAR_Year(Start_Date__c)=:selectedYear AND Status__c ='Completed' AND company__r.Id=:Id];
        
        System.debug(Id);
    }
    
}