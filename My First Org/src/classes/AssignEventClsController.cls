public class AssignEventClsController {

	public List<AssignEventWrapper> lstWrapper {get;set;}
	public List<AssignEventWrapper> lstSetController{get;set;}
    public Employee__c objEmp{get;set;}    
    public List<AssignEventWrapper> lstwrap{get;set;}
    public List<SelectOption> lstoptions{get;set;}
    public String strParmEmpId{get;set;}

	CustomEventIterCls obj;

    public AssignEventClsController() 
    {
        strParmEmpId='a0Y7F000000Hf81';
        objEmp=new Employee__c();
        objEmp=[select Id,Name,Company__c,Department__c,Job_Role__c from Employee__c where Id=:strParmEmpId];
        FillEvent();
    }
    
    public void FillEvent()
    {        
        lstWrapper =  new List<AssignEventWrapper>();
        lstSetController = new List<AssignEventWrapper>();
        List<Event__c> lstEvent = [select Id,Name from Event__c where Status__c='Scheduled' OR Status__c='In Progress'];        
        
        for(Event__c evnt : lstEvent )
        {
            lstWrapper.add(new AssignEventWrapper(evnt ,false));
        }

        obj = new CustomEventIterCls (lstWrapper); 
        obj.setPageSize = 2;
        next();       
    }
    
    
    public Boolean hasNext {
            get 
            {
                return obj.hasNext();
            }
            set;
    }   
    public Boolean hasPrevious {
            get 
            {
                return obj.hasPrevious();
            }
            set;
    }
        
    public void next() 
    {
        lstSetController = obj.next();
    }
        
    public void previous() 
    {
        lstSetController = obj.previous();
    }
    
    public PageReference EventSubmit()
    {        
        List<AssignEventWrapper> mylstwrap=new List<AssignEventWrapper>();
        List<Event_Attendees__c> lstEventAttend=new List<Event_Attendees__c>();
        system.debug('helo2');
        for(AssignEventWrapper a:lstWrapper)
        {
			if(a.chkEvent==true)
            {
                //system.debug(a.evnt.Name+','+a.sptype);
                Event_Attendees__c objEventAttend=new Event_Attendees__c();                
                objEventAttend.Employee__c=strParmEmpId;//a.strEmpId;
				objEventAttend.Event__c=a.evnt.Id;
				objEventAttend.Participation_Type__c=a.sptype;
                lstEventAttend.add(objEventAttend);
            }            
        }
        if(!lstEventAttend.isEmpty())
        {
            insert lstEventAttend;
        }        
        //system.debug(lstEventAttend);
        //return null;
        PageReference retURL = new PageReference('https://ap5.salesforce.com/a0H/o');
      	retURL.setRedirect(true);
      	return retURL;
    }

}