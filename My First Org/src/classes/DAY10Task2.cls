/*
Description : Get the list of records with the matching search string(Controller). 
Author: Praveen Goud
Date Of Creation: 04-07-2017
Last Modification: 04-07-2017
Modification History: 
*/
public class DAY10Task2 {
    
    public Boolean viewFields{set;get;}
    public Boolean showPickListValues{set;get;}
    public Boolean viewChilds{set;get;}
    public Boolean showFieldss{set;get;}
    public Boolean showTable{set;get;}
    public List<SelectOption> options{set;get;}
    public List<SelectOption> options1{set;get;}
    public List<SelectOption> options2{set;get;}
    public List<SelectOption> options3{set;get;}
    public List<Contact> conList{set;get;}
    public String selectedOption{set;get;}
    public String selectedField{set;get;}
    public SObjectType contactType = Schema.getGlobalDescribe().get('Contact');
    /*
    Description : This Method is used to get all the fields in Contact object.
    */
    public void getFields() {
        Map<String, Schema.SObjectField> contactFields = new Map<String, Schema.SObjectField>();
        viewFields=true;
        contactFields = contactType.getDescribe().fields.getMap();
        options = new List<SelectOption>();
        options.add(new SelectOption('--None--','--None--'));
        for(String key:contactFields.keySet()){
            options.add(new SelectOption(key,key));
        }
    }
    /*
    Description : This Method is used to get all the picklist values of Leadsource in Contact object.
    */
    public void getPickListValues() {
        showPickListValues=true;
        options1 = new List<SelectOption>();
        options1.add(new SelectOption('--None--','--None--'));
        Schema.DescribeFieldResult fieldResult = Contact.LeadSource.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        system.debug(ple);
        for(Schema.PicklistEntry va : ple) {
            options1.add(new SelectOption(va.getlabel(),va.getValue()));
        }
    }
    /*
    Description : This Method is used to get all the Child objects in Contact object.
    */
    public void getChildRelatedLists() {
        viewChilds = true;
        options2 = new List<SelectOption>();
        options2.add(new SelectOption('--None--','--None--'));
        List<Schema.ChildRelationship> childList = contactType.getDescribe().getChildRelationships();
        for(Schema.ChildRelationship scr : childList) {
            if(scr.getRelationshipName() != null){
            options2.add(new SelectOption(scr.getRelationshipName(),scr.getRelationshipName()));
            }
        }
    }
    /*
    Description : This Method is used to get all the records Contact object.
    */
    public void getRecords() {
        showFieldss = true;
        options3 = new List<SelectOption>();
        options3.add(new SelectOption('--None--','--None--'));
        conList = [Select id,LastName From Contact];
        for(Contact con : conList) {
			options3.add(new SelectOption(con.Id,con.LastName));
        }
        
    }
    /*
    Description : This Method is used to display the value of selected field in Contact object.
    */
    public void display()  {
        showTable = true;
        String search = 'SELECT ';
        search += selectedField+' ';
        search += 'FROM Contact WHERE id=';
        search += ':selectedOption';
        System.debug(selectedField);
        System.debug(search);
        try{
       	conList =  Database.query(search);
        }
        catch(exception e) {
          	e.getMessage();
        }
    }
}