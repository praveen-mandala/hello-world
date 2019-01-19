/*
Description :  Trigger for Opportunity Object
Author: Praveen Goud
Date Of Creation: 07-07-2017
Last Modification: 07-07-2017
Modification History: null
*/
trigger BootCampOpportunityTrigger on Opportunity (after insert , after update , after delete) {
    
    // Calculate All related opportunity amount into account
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete) {
        List<Id> accountIdLst = new List<Id>();
        for(Opportunity oppObj : (Trigger.isInsert || Trigger.isUpdate)?Trigger.New : Trigger.Old) {
            if(oppObj.AccountId != null && oppObj.Amount != null){
                accountIdLst.add(oppObj.AccountId);
            }
        }
        OpportunityTriggerHandler opportunityTriggerHandler = new OpportunityTriggerHandler();
        update opportunityTriggerHandler.calculateTotalAmount(accountIdLst);
    }
    
}