trigger AddRelatedRecord on Account (after insert , after update) {
/*
    List<Opportunity> oppList = [SELECT id,Name FROM Opportunity Where Account.id IN :Trigger.New];
    List<Opportunity> oppList1 = new List<Opportunity>();
    for(Opportunity opp : oppList) {

        opp.description = 'Description Changed';
        oppList1.add(opp);
    }
    
    update oppList1;*/
    List<Opportunity> oppList = new List<Opportunity>();
    List<Account> accList = [SELECT id,Name From Account WHERE id IN :Trigger.New AND id NOT IN(SELECT AccountId FROM Opportunity)];
    for(Account acc : accList){
    
        System.debug(acc.Id);
        oppList.add(new Opportunity(Name=acc.Name + ' Opportunity',
                                   StageName='Prospecting',
                                   CloseDate=System.today().addMonths(1),
                                   AccountId=acc.Id)); 
    }
    if(oppList.size()>0){

        insert oppList;
    }
}