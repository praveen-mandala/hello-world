trigger AccNew on Account (before insert , before update) {

    
    List<Account> accList = [SELECT id,Name FROM Account WHERE Type='Customer' AND Id IN :Trigger.New];
    for(Account acc : accList){
        
        acc.Rating='Hot';
    }
}