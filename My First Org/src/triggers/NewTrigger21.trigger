trigger NewTrigger21 on Account (before insert) {

    List<Account> acc1 = [SELECT Id,AccountNumber FROM Account WHERE ID IN :Trigger.Old];
     for(Account acc : acc1) {
        String a = acc.AccountNumber;
        if(!a.isNumeric()){
            Trigger.OldMap.get(acc.Id).addError('Please enter only numericals for the account number');
        }
    }
}