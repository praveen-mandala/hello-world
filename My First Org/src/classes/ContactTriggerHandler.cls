/*
Description :  TriggerHandler for Contact Trigger
Author: Praveen Goud
Date Of Creation: 07-07-2017
Last Modification: 09-07-2017
Modification History: null
*/
public class ContactTriggerHandler {
    
    /*
     * Name:calulateTotalSalary
     * Param:accountIdLst --List of accounts Ids
     * Param:newContactLst --List of new Contacts
     * Description: Create new task when phone number is changed.
     */
    public List<Account> calulateTotalSalary (List<Id> accountIdLst , List<Contact> newContactLst) {
        List<Account> updatedAccList = getAccountLst(accountIdLst);
        system.debug(updatedAccList);
        for(Account a : updatedAccList) {
            List<Contact> conn = a.Contacts;
            Decimal salaryTotal=0;
            for(Contact ccc : conn) {
                if(ccc.Salary__c != null) {
                    salaryTotal += ccc.Salary__c;
                }
            }
            a.Total_Salary__c = salaryTotal;
        }
        return updatedAccList;
    }
    
    /*
     * Name:calulateTotalSalary
     * Param:accountIdLst --List of accounts Ids
     * Param:newContactLst --List of new Contacts
     * Description: When contact status is active, then inactive all related account contacts and update active contact email
     */
    public List<List<sObject>> updateAccountEmail(List<Id> accountIdLst , List<Contact> newContactLst) {
        List<List<sObject>> accConLst = new List<List<sObject>>();
        List<contact> updatedConList=new List<contact>(); 
        List<Account> updatedAccList = getAccountLst(accountIdLst);
        for(Account a : updatedAccList) {
            system.debug('Account '+a);
            List<Contact> conn = a.Contacts;
            system.debug('Contacts '+conn);
            for(Contact cntObjnew : newContactLst){
                if(cntObjnew.AccountId==a.id){
                    if(cntObjnew.Active__C){
                        a.Email__c=cntObjnew.email;
                        for(Contact cntObj:conn){
                            if(cntObjnew.id!=cntObj.id){
                                cntObj.Active__c=false;
                                updatedConList.add(cntObj);
                            }
                        }
                    } 
                }
            } 
        }
        accConLst.add(updatedAccList);
        accConLst.add(updatedConList);
        return accConLst;
    }
    
    
    
    
    public List<Account> getAccountLst(List<ID> accountIdLst) {
        return [Select Id,Total_Salary__c ,(Select Id,LastName,Salary__c from Contacts) from Account Where Id IN :accountIdLst];
    }
}