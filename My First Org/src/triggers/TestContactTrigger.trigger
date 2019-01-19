trigger TestContactTrigger on Contact (after insert , after update ,after delete) {
    
    public List<Id> accountIdLst = new List<Id>();  
    System.debug('TEST');
    
        for(Contact cntObj:(Trigger.isInsert || Trigger.isUpdate)?Trigger.New : Trigger.Old){
          
            if(cntObj.AccountId != null) {
                accountIdLst.add(cntObj.AccountId); 
            }
        }
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete) {
        ContactTriggerHandler contactTriggerHandler = new ContactTriggerHandler();
        update contactTriggerHandler.calulateTotalSalary(accountIdLst, Trigger.New);
    } 
    
    if(Trigger.isInsert || Trigger.isUpdate) {
        System.debug(accountIdLst);
        ContactTriggerHandler contactTriggerHandler = new ContactTriggerHandler();
        List<List<sObject>> sList  = contactTriggerHandler.updateAccountEmail(accountIdLst, Trigger.New);
                update sList[0];
                update sList[1];
    }
    
    
    
}