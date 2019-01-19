trigger NewTrigger on Account (after insert , after update) {

    List<Account> acc = [SELECT id,Type,Rating FROM Account WHERE ID IN :Trigger.New];
     List<Account> acc2 = new List<Account>();
     for(Account acc1 : acc) {
        System.debug(acc1.Type);
        if(acc1.Type == 'Customer')
        {
            
            acc1.Rating='Hot';
            acc2.add(acc1);
        }
        
        
    }
    update acc2;
}