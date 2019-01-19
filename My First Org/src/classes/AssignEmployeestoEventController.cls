/*
Description : Apex Controller Class to get all the required values
Author: Praveen Goud
Date Of Creation: 19-07-2017
Last Modification: 21-07-2017
*/
public class AssignEmployeestoEventController {
    
    
    public List<EventsWrapperClass> lstWrapper {get;set;} //This list is used to get and set EventsWrapperClass obj. 
    public List<EventsWrapperClass> paginationlst{get;set;} //This list is used display records on the VF page
    public Event__c objEvent{get;set;}//Used to show event details on VF page
    public String strParmEventId{get;set;}
    EmployeeIterator obj;//EmployeeIterator obj to check hasPrevious,hasNext and to send list to Iterator
    
    //Gets the Id from the button and the list of Employees
    public AssignEmployeestoEventController() 
    {
        strParmEventId = '';
        if(ApexPages.currentPage().getParameters().containsKey('Id')){
            strParmEventId=ApexPages.currentPage().getParameters().get('Id');
        }
        System.debug('strParmEventId '+strParmEventId);
        if(strParmEventId != '') {
            System.debug('after IF');
        objEvent=new Event__c();
        objEvent=[Select Id,
                  Name,
                  Company__r.Name,
                  Category__c,
                  Type__c,
                  Start_Date__c,
                  End_Date__c 
                  From 
                  Event__C 
                  Where Id=:strParmEventId];
            List<Event_Attendees__c> attendeesLst = [Select Name,Employee__r.Id From Event_Attendees__c Where Event__r.Id = :objEvent.Id];
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
            getDetails(employeeLst);
        }
        else {
            obj = null;
            lstWrapper = new List<EventsWrapperClass>();
            objEvent=new Event__c();
        }
    }
    /* 
     * Description : This method creates a list of wrapper class objects and passes it to Iterator
     * Param : list of Employees
     */
    public void getDetails(List<Employee__c> employeeLst1) {
        lstWrapper = new List<EventsWrapperClass>();
        for(Employee__c emp : employeeLst1 )
        {
            lstWrapper.add(new EventsWrapperClass(emp ,false));//Adding employees to Wrapper with checked value as false 
        }
        obj = new EmployeeIterator (lstWrapper); 
        obj.setPageSize = 2;
        next();//gets required set of records
    }
    //Used for rendering Next button in the VF page
    public Boolean hasNext {
        get 
        {
            if(obj != null){
                return obj.hasNext();}
            return false;
        }
        set;
    }
    //Used for rendering Previous button in the VF page
    public Boolean hasPrevious {
        get 
        {
            if(obj != null){
                return obj.hasPrevious();}
            return false;
        }
        set;
    }
    //Called when next button is clicked and loads the next set of objects 
    public void next() 
    {
         if(obj != null){
             paginationlst = obj.next();}
    }
    //Called when previous button is clicked and loads the previous set of objects
    public void previous() 
    {
        if(obj != null){
             paginationlst = obj.previous();}
    }
    /* 
     * Description : This method inserts the list of Event_Attendees__c objects
     * return : PageReference to the Event detail page
     */
    public PageReference createRecords() {
        try
        {
            List<Event_Attendees__c> eventAttendeeslst = new List<Event_Attendees__c>();
            
            for(EventsWrapperClass obj : lstWrapper) {
                
                if(obj.checkedEmp == true && obj.selectedOption != '--select--') {
                    Event_Attendees__c aA = new Event_Attendees__c();
                    aA.Event__c = objEvent.Id;
                    aA.Employee__c = obj.empObj.Id;
                    aA.Participation_Type__c = obj.selectedOption;
                    eventAttendeeslst.add(aA);
                 }
                
            }
            if(eventAttendeeslst.size() > 0){
                insert eventAttendeeslst;
            }
            }
        catch(Exception ex)
        {
           ex.getMessage();
        }
            return new PageReference('/'+objEvent.Id);
        
    }
    
}