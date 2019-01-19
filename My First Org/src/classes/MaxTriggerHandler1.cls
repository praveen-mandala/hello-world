public class MaxTriggerHandler1 extends TriggerHandler{
    public static boolean checkflag=true;
    public override void beforeInsert() {
        
    }
    
    public override void afterUpdate() {
        if(checkflag){
          checkflag=false;  
            System.debug('Trigger.New '+Trigger.New);
            system.debug('Trigger.NewMap '+Trigger.NewMap);
        List<Contact> conAccList = new List<Contact>();
        List<Contact> conListNew =  Trigger.New;
        List<Id> accId = new List<Id>();
        List<Account> accList = new List<Account>();
        System.debug('conListNew '+conListNew);
        for(Contact con : conListNew) {
            if(con.Max__c || con.Active__c) {
                System.debug('Max true');
                accId.add(con.AccountId);
            }
        }
        accList = [Select Id,(Select Id,LastName,Active__c,Max__c From Contacts) From Account Where ID IN :accId];
        System.debug('accList '+accList);
        for(Account acc : accList) {
            boolean maxFlag = false;
            boolean activeFlag = false;
            conAccList = acc.Contacts;
            System.debug('conAccList '+conAccList);
            for(Contact conAccN : conAccList) {
                if(Trigger.NewMap.containsKey(conAccN.Id)){
                    if(conAccN.Active__c && !conAccN.Max__c){activeFlag = true;}
                    else if(conAccN.Max__c && !conAccN.Active__c){maxFlag = true;}
                    else {activeFlag = true;maxFlag = true;}
                }
            }
            for(Contact conAccN : conAccList) {
                if(!Trigger.NewMap.containsKey(conAccN.Id) && maxFlag && !activeFlag){
                    System.debug('If contains');
                    conAccN.Max__c = false;
                }
                else if(!Trigger.NewMap.containsKey(conAccN.Id) && activeFlag && !maxFlag){
                    System.debug('If contains');
                    conAccN.Active__c = false;
                }
                 else if(!Trigger.NewMap.containsKey(conAccN.Id) && activeFlag && maxFlag){
                    conAccN.Max__c = false;
                    conAccN.Active__c = false;
                }
                
            }
        }
        System.debug('conAccList '+conAccList);
        update conAccList;
        }
    }
}