/*
* Author:Praveen Goud
* Decription:Fires after inserting an employee to event and update the HostedBY and CoordinatedBy feilds
* Created Date:20-07-2007
* LastModification date:null;
*/
Trigger HostedByTriggerEA on Event_Attendees__c ( before insert,after insert ,before update ,after update , before delete ,after delete ) {
    
    if(Trigger.IsAfter && Trigger.IsInsert) {
        List<Id> eventIdLst = new List<Id>();
        for(Event_Attendees__c eaObj:Trigger.New ){
            eventIdLst.add(eaObj.Event__c); 
        }
        EventTriggerHandler eventTriggerHandler = new EventTriggerHandler();
        update eventTriggerHandler.getHostedNames(eventIdLst);
        update eventTriggerHandler.getCoordinatorNames(eventIdLst);
    }
}