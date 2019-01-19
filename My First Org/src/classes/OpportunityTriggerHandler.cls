/*
Description : TriggerHandler for Opportunity Trigger
Author: Praveen Goud
Date Of Creation: 07-07-2017
Last Modification: 07-07-2017
Modification History: null
*/
public class OpportunityTriggerHandler {
    
    /*
     * Name:calulateTotalSalary
     * Param:accountIdLst --List of accounts Ids
     * Param:newContactLst --List of new Contacts
     * Description: Calculate All related opportunity amount into account
     */
    public List<Account> calculateTotalAmount(List<Id> accountIdLst) {
        List<Account> updatedAccountLst = new List<Account>();
        List<Account> accountWithOppLst = [Select Id,(Select Id,Amount From Opportunities) From Account Where Id IN :accountIdLst];
        for(Account accObj : accountWithOppLst) {
            Decimal totalAmount = 0;
            for(Opportunity oppObj : accObj.Opportunities) {
                totalAmount += oppObj.Amount;
            }
            system.debug('totalAmount '+totalAmount);
            accObj.Total_Opportunity_Amount__c	= totalAmount;
            updatedAccountLst.add(accObj);
        }
        System.debug('updatedAccountLst '+updatedAccountLst);
        return updatedAccountLst;
    }
    
}