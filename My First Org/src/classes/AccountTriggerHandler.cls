/*
Description :  Trigger Handler for Account Trigger
Author: Praveen Goud
Date Of Creation: 07-07-2017
Last Modification: 09-07-2017
Modification History: null
*/
public class AccountTriggerHandler {
    
    /*
     * Name:createContacts
     * Param:accountList --List of account Ids
     * Description: create Contact when Account is created.
     */
    public List<Contact> createContacts(List<Account> accountList) {
        List<Contact> contactList = new List<Contact>();
        for(Account newAccount: accountList) {
            Contact newContact = new Contact();
            newContact.AccountId = newAccount.Id;
            newContact.LastName = newAccount.Name+'TestContact';
            newContact.Description = 'This is Test Contact Inserted by BootCampAccountTrigger';
            contactList.add(newContact);
        }
        return contactList;
    }

    /*
     * Name:createTasks
     * Param:oldAccountList --List of old accounts
     * Param:newAccountList --List of new accounts
     * Description: Create new task when phone number is changed.
     */
    public List<Task> createTasks(List<Account> oldAccountList , List<Account> newAccountList) {
        List<Task> taskList = new List<Task>();
        for(Account newAccount: newAccountList) {
            for(Account oldAccount : oldAccountList) {
                if(newAccount.Phone != oldAccount.Phone) {
                    Task newTask = new Task();
                    newTask.Subject = 'BootCampAccountTrigger Task';
                    newTask.Status = 'Not Started';
                    newTask.WhatId = newAccount.Id;
                    taskList.add(newTask);
                }
            }
        }
        return taskList;
    }
}