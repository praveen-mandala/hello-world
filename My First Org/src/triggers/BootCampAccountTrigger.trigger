/*
Description :  Trigger on Account Object
Author: Praveen Goud
Date Of Creation: 07-07-2017
Last Modification: 09-07-2017
Modification History: null
*/
trigger BootCampAccountTrigger on Account (after insert , after update) {
    AccountTriggerHandler triggerHandler = new AccountTriggerHandler();
    
    //Create Default Contact when account is created
    if(Trigger.isInsert) {
        List<Account> accountList = Trigger.New;
        insert triggerHandler.createContacts(accountList);
        
    }
    //Create new task when phone number is changed
    if(Trigger.isUpdate) {
        List<Account> accountList = Trigger.New;
        List<Account> oldAccountList = Trigger.Old;
        insert triggerHandler.createTasks(oldAccountList , accountList);
    }
    
}