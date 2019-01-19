trigger AccDup on Account (after insert ) {

    List<Account> accList1 = new List<Account>();
        List<Account> accList = Trigger.New; 
    Account a = new Account();
   
   
    for(Account acc : accList) {
        if(TestA.flag){
         
        System.debug('Trigger');
        system.debug(acc.Name);
        a.Name = acc.Name;
        a.OwnerId = '0057F000000V1PdQAK';
       accList1.add(a);
            
    }
         //TestA.flag = true;
    }
    TestA.flag = false;
    upsert accList1;
}