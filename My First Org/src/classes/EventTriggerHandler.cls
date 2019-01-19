/*
* Author:Praveen Goud
* Decription:This is the handler class for HostedByTriggerEA
* Created Date:20-07-2007
* LastModification date:null;
*/
public class EventTriggerHandler {
    //updates the hostedBy fields and return the list of Events
    public List<Event__c> getHostedNames(List<Id> eventIdLst) {
        List<Event__c> eveList = [Select 
                                  Id,
                                  Name,
                                  (Select 
                                   Id,
                                   Name,
                                   Employee__r.Name,
                                   Participation_Type__c 
                                   from Event_Attendees__r 
                                   where Participation_Type__c ='Host') 
                                  From Event__c 
                                  Where Id IN :eventIdLst];
        for(Event__c eve : eveList) {
            List<Event_Attendees__c> eaList = eve.Event_Attendees__r;
            String s='';
            for(Event_Attendees__c ea : eaList) {
                s += s.equals('')?ea.Employee__r.Name:':'+ea.Employee__r.Name;
            }
            
            eve.Hosted_By__c = s;
        }
        return eveList;
    }
    //updates the CoordinatorBy fields and return the list of Events
    public List<Event__c> getCoordinatorNames(List<Id> eventIdLst) {
        List<Event__c> eveCoordinatorList = [Select 
                                             Id,
                                             Name,
                                             (Select 
                                              Id,
                                              Name,
                                              Employee__r.Name,
                                              Participation_Type__c 
                                              from Event_Attendees__r 
                                              where Participation_Type__c ='Coordinator') 
                                             From Event__c 
                                             Where Id IN :eventIdLst];
        for(Event__c eve : eveCoordinatorList) {
            List<Event_Attendees__c> eaList = eve.Event_Attendees__r;
            String s='';
            for(Event_Attendees__c ea : eaList) {
                s += s.equals('')?ea.Employee__r.Name:':'+ea.Employee__r.Name;
            }
            
            eve.Coordinated_By__c = s;
        }
        return eveCoordinatorList;
    }
}