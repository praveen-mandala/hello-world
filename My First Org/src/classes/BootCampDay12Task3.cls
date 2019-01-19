/*
 Description : Apex Batch Class to find all the records created between given time interval
 Author: Praveen Goud
 Date Of Creation: 09-07-2017
 Last Modification: 09-07-2017
 Modification History: null
*/
global class BootCampDay12Task3 implements Database.Batchable<sObject> {
    
    //This variable is used to note the time interval in hours
    global final Integer interval;
    
    global BootCampDay12Task3(Integer intt) {
        interval = intt;
    }
    global Database.QueryLocator start(Database.BatchableContext BC){
        DateTime dt1 = System.now().addHours(-interval);
        DateTime dt2 = System.now();
        String query = 'Select Id,LastName,CreatedDate From Contact Where CreatedDate > :dt1 and CreatedDate < :dt2';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        List<Contact> conList = new List<Contact> ();
        conList = scope;
        system.debug('conList '+conList);
        Log__c logObj = new Log__c();
        logObj.Record_Count__c = conList.size();
        logObj.Time_Interval_in_hours__c = interval;
        String contactIds = '';
        for(Contact ccc: conList) {
            contactIds += ccc.Id;
            contactIds += ',';
        }
        String newString = contactIds.substring(0, contactIds.length()-1);
        logObj.Created_Records__c = newString;
        insert logObj;
    }
    
    global void finish(Database.BatchableContext BC) {
        
    }
}