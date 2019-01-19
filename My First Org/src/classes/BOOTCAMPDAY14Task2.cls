/*
 Description : Apex batch class to find tax on amount in Invoice record
 Author: Praveen Goud
 Date Of Creation: 11-07-2017
 Last Modification: 17-07-2017
 Modification History: null
*/
global class BOOTCAMPDAY14Task2 implements Database.Batchable<sObject>,Database.AllowsCallouts {
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'Select Id,Name,Amount__c,Taxes__c,(Select Id,Amount__c From Invoice_Line_Items__r) From Invoice__c';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope) { 
        List<Invoice__c> updateInvoiceList = new List<Invoice__c>();
        for(sObject inv : scope) {
            CallWEBService callWEBService = new CallWEBService();
            updateInvoiceList.add(callWEBService.calculateTaxes(inv));
        }
        update updateInvoiceList;
    }
    
    global void finish(Database.BatchableContext BC) {
        
    }
}