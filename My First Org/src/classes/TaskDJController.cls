public class TaskDJController {

    public List<Event__c> evntList{get;set;}
    public Map<String,List<Event__c>> finalMap{get;set;}
    public ApexPages.StandardSetController setCon{get;set;} 
    public TaskDJController () {
        evntList = [Select Id,Name,Status__c From Event__c Where Status__c = 'In Progress' Or Status__c='Approved' Or Status__c='Scheduled'];
        setCon = new ApexPages.StandardSetController(evntList);
		getDetails();
    }
    public void getDetails() {
        finalMap = new Map<String,List<Event__c>>();
        for(Event__c eObj : evntList) {
            if(finalMap.containsKey(eObj.Status__c)) {
               finalMap.get(eObj.Status__c).add(eObj);
            }
            else {
                List<Event__c> newEve = new List<Event__c>();
                newEve.add(eObj);
                finalMap.put(eObj.Status__c, newEve);
            }
        }
        System.debug('finalMap '+finalMap);
    }
    public void next() {
        
    }
    
}