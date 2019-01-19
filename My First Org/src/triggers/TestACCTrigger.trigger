trigger TestACCTrigger on Account (after insert , after update) {
    AccountTriggerHandler triggerHandler = new AccountTriggerHandler();
    if(Trigger.isInsert) {
        List<Account> accountList = Trigger.New;
        insert triggerHandler.createContacts(accountList);

}
    if(Trigger.isUpdate) {
        List<Account> accountList = Trigger.New;
        List<Account> oldAccountList = Trigger.Old;
        insert triggerHandler.createTasks(oldAccountList , accountList);
    }
    
}