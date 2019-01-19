/*
Author Name : Praveen
Date : 26/5/2017
Description : Create Contact for Account
Modification History :
*/
trigger AccDefaultContactCreationTrigger on Account (after insert,after update) {
    
List<Account> accList = [Select Id,Name,Owner.Email From Account Where Id IN :Trigger.New];
List<Contact> conList =new List<Contact>();
    for(Account acc : accList) {
        
        Contact con = new Contact(LastName='TestTrigger',AccountId=acc.Id,Email=acc.Owner.Email);
        
        conList.add(con);
    }
     if(!conList.isEmpty()){
   insert conList;
        
     }
}