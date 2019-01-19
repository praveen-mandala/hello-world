/*
Description : Events Wrapper Class to store the Checkbox,Selected option and also the Employee Object
Author: Praveen Goud
Date Of Creation: 19-07-2017
Last Modification: 21-07-2017
*/
global class EventsWrapperClass {
    
    public string selectedOption{get;set;}//The option selected from the participation type
    public boolean checkedEmp{get;set;}//checkbox in the VF page
    public Employee__c empObj{get;set;}//Used to hold the employee Object
    public EventsWrapperClass(Employee__c emp , Boolean isSelected) {
        empObj = emp;
        checkedEmp = isSelected;
    }
    //This method is used to get all the options of Participation_Type__c.
    public List<SelectOption> getItems() {
        
        List<SelectOption> options = new List<SelectOption>();
        
        Schema.DescribeFieldResult fieldResult =
            Event_Attendees__c.Participation_Type__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        options.add(new SelectOption('--select--', '--select--'));
        for( Schema.PicklistEntry f : ple)
        {
            options.add(new SelectOption(f.getLabel(), f.getValue()));
        } 
        return options;
    }
}