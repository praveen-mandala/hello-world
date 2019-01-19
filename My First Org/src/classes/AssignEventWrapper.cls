global class AssignEventWrapper {
    
    public boolean chkEvent{get;set;}
    public string strEventName{get;set;}
    public string strEventId{get;set;}
    public string strEmpId{get;set;}
    public String sptype ;
            
    public List<SelectOption> getItems() {
          List<SelectOption> options = new List<SelectOption>();
          options.add(new SelectOption('Host','Host'));
          options.add(new SelectOption('Coordinator','Coordinator'));
          options.add(new SelectOption('Participant','Participant'));
          return options;
    }
            
    public String getSptype() {
            return sptype;
    }
            
    public void setSptype(String sptype) {
            this.sptype = sptype;
    }
    
    public Boolean isSelected {get;set;}
	public Event__c evnt{get;set;}
    public AssignEventWrapper(Event__c ievnt,Boolean isSelected)
    {
        this.evnt= ievnt;
        this.chkEvent= isSelected;
    }

}