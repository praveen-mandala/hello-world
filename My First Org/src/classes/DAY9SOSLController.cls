/*
Description : Get the list of records with the matching search string. 
Author: Praveen Goud
Date Of Creation: 03-07-2017
Last Modification: 03-07-2017
Modification History: 
*/
public class DAY9SOSLController {
    public String searchquery{set;get;}
    public String searchText{set;get;}
    public List<Account> accList{set;get;}
    public List<Contact> conList{set;get;}
    public List<Lead> leadList{set;get;}
    public List<Test__c> testList{set;get;}
    public List<Session__c> sessionList{set;get;}
    public List<List<sObject>> searchResult{set;get;}
    public boolean accflag{set;get;}
    public boolean conflag{set;get;}
    public boolean leadflag{set;get;}
    public boolean testflag{set;get;}
    public boolean sessionflag{set;get;}
    
    public void getRecords() {
        System.debug(searchText);
        searchquery='FIND \'*'+searchText+'*\' IN ALL FIELDS RETURNING Account(id,name,Owner.Name),Contact(id,LastName,Email), Lead(id,Name,Email),Test__c(id,Name),Session__c(id,Name)';
        searchResult=search.query(searchquery);
        accList = searchResult.get(0);
        conList = searchResult.get(1);
        leadList = searchResult.get(2);
        testList = searchResult.get(3);
        sessionList = searchResult.get(4);
        System.debug(accList.size());
        if(accList.size()==0) {
            accflag = true;
        }
        else{accflag = false;}
        if(conList.size()==0) {
            conflag = true;
        }
        else{conflag = false;}
        if(leadList.size() == 0) {
            leadflag=true;
        }
        else{leadflag = false;}
        if(testList.size() == 0) {
            testflag=true;
        }
        else{testflag = false;}
        if(sessionList.size() == 0) {
            sessionflag=true;
        }
        else{sessionflag = false;}
    }
}