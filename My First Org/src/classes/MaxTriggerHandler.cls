public class MaxTriggerHandler extends TriggerHandler{
    
    public MaxTriggerHandler() {
        this.setMaxLoopCount(1);
    }
    public override void beforeInsert() {
        utilityMethod(Trigger.New);
    }
    
   /* public override void beforeUpdate() {
        utilityMethod(Trigger.New);
    }*/
    
    public void utilityMethod(List<Contact> conList) {
        
        System.debug('Create');
        System.debug('UtilityMeth');
        //List<Contact> conList = Trigger.New;
        List<Contact> newConList = new List<Contact>();
        Boolean maxFlag = false;
        Boolean activeFlag = false;
        Set<ID> accId = new Set<ID>();
        for(Contact con : conList) {
            if(con.Max__c || con.Active__c) {
                accId.add(con.AccountId);
            }
        }
        System.debug('after for1');
        List<Account> accList = [Select Id,(Select Id,Max__c,LastName from Contacts) from Account Where ID IN :accId];
        for(Account acc: accList){
            System.debug('after for2');
            newConList = acc.Contacts;
            for(Contact ccc : conList){
                System.debug('after for3');
                if(ccc.Max__c || ccc.Active__c){
                if(ccc.AccountId == acc.Id && ccc.Max__c){
                    maxFlag=true;
                }
                if(ccc.AccountId == acc.Id && ccc.Active__c) {
                    activeFlag=true;
                }}
            }
            System.debug('newConList '+newConList);
            for(Contact conNew : newConList) {
                System.debug('after for4');
                if(maxFlag){
                    conNew.Max__c = false;
                }
                if(activeFlag) {
                    conNew.Active__c = false;
                }
            }
            System.debug('newConList after update'+newConList);
        }
        System.debug('update');
        if(newConList.size()>0){
            update newConList;}
    
    }
}