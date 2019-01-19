/*
 Description : This Batch Apex Class is used to create a task for all Contacts with Phone
 Author: Praveen Goud
 Date Of Creation: 09-07-2017
 Last Modification: 09-07-2017
 Modification History: null
 */
global class BootCampDay12Task2 implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        System.debug('Start');
        String query = 'Select Id,LastName,Phone From Contact Where Phone != \'\'';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        List<Contact> conList = new List<Contact> ();
        List<Task> taskList = new List<Task> ();
        conList = scope;
        for(Contact con : conList) {
            Task taskObj = new Task();
            taskObj.WhoId = con.Id;
            taskObj.Status = 'Not Started';
            taskObj.Subject = 'Created by batch Apex';
            taskObj.Priority = 'Normal';
            taskList.add(taskObj);
        }
        insert taskList;
    }
    
    global void finish(Database.BatchableContext BC) {
        
    }
    
}