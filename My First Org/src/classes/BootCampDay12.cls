/*
 Description : This Batch Apex Class is used to delete all the Contacts with duplicate Emails
 Author: Praveen Goud
 Date Of Creation: 09-07-2017
 Last Modification: 10-07-2017
 Modification History: null
 */
global class BootCampDay12 implements Database.Batchable<sObject>,Database.Stateful {
    
    global Set<String> emailSet = new Set<String>();
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'Select Id,Email,LastName,(Select Id From Cases) From Contact';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope) { 
        List<Contact> conList = new List<Contact>();
        List<Case> deleteCaseList = new List<Case>();
        List<Contact> deleteConList = new List<Contact>();
        conList = scope;
        for(Contact con : conList) {
            if(!emailSet.add(con.Email)) {
                deleteConList.add(con);
                if(con.Cases.size()>0) {
                deleteCaseList.addAll(con.Cases);
                }
            }
            else{emailSet.add(con.Email);}
        }
        delete deleteCaseList;
        delete deleteConList;
    }
    
    global void finish(Database.BatchableContext BC) {
        
    }
}