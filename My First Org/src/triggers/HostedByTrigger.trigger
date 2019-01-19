trigger HostedByTrigger on Event__c (after insert) {

    List<Event__c> eventList = [select Id,Name From Event__c Where Id IN :Trigger.New];
    
}