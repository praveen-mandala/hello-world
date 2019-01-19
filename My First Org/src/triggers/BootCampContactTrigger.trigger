/*
Description :  Trigger for Contact Object
Author: Praveen Goud
Date Of Creation: 07-07-2017
Last Modification: 09-07-2017
Modification History: null
*/

trigger BootCampContactTrigger on Contact (after insert , after update ,after delete) {
    
    //Get List of Account Id's from Contacts
    public List<Id> accountIdLst = new List<Id>();  
    for(Contact cntObj:(Trigger.isInsert || Trigger.isUpdate)?Trigger.New : Trigger.Old){
        if(cntObj.AccountId != null) {
            accountIdLst.add(cntObj.AccountId); 
        }
    }
    // Calculate Total Salary from related Contacts
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete) {
        ContactTriggerHandler contactTriggerHandler = new ContactTriggerHandler();
        update contactTriggerHandler.calulateTotalSalary(accountIdLst, Trigger.New);
    } 
    //When contact status is active, then inactive all related account contacts and update active contact email
    if(Trigger.isInsert || Trigger.isUpdate) {
        ContactTriggerHandler contactTriggerHandler = new ContactTriggerHandler();
        List<List<sObject>> sList  = contactTriggerHandler.updateAccountEmail(accountIdLst, Trigger.New);
        update sList[0];
        update sList[1];
    }
}