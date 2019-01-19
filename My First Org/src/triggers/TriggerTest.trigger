trigger TriggerTest on Account (before insert , before update) {
    
    System.debug('Account inserted');
    List<Account> accList = [SELECT id,Name From Account WHERE id IN :Trigger.New];
    for(Account acc : accList) {
        System.debug(acc);
        if(acc.Industry == 'Media')
        {acc.Rating = 'Cold ';}
    }

}