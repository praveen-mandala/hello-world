trigger SessionTrigger1 on Session_Speaker__c (before insert , before update) {

    List<Session__c> sc = new List<Session__c>();
    
    for(Session_Speaker__c a : trigger.New){
        
        List<Id> sr = new List<Id>();
        sr.add(a.Speaker__c);
    }
    //check once
    List<Session_Speaker__c> ssc = [SELECT Session__r.ID FROM Session_Speaker__c WHERE ID IN :Trigger.New];
    for(Session_Speaker__c ssc1 : ssc) {
        Trigger.NewMap.get(ssc1.Id).addError('No Duplicates');
    }
    
    
}