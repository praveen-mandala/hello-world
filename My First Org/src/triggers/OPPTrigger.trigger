trigger OPPTrigger on Opportunity (After insert,After update) {

    
    Map<Id,Decimal> accIdamntMap=new Map<id,Decimal>();
    List<Account> updatedList=new List<Account>();
    Map<id,List<Contract>> accidContactID=new  Map<id,List<Contract>>();
    List<order> orderList=new List<order>();
    /*List<id> accList=new List<id>();
    for(Opportunity oppObj:Trigger.New){
        accList.add( oppObj.AccountId);
    }*/
   // List<Contract> contractObj= [select id,Account.id  from Contract where Accountid in :accList];
   List<Id> accid=new List<id>();
    List<Id> oppid=new List<id>();
    for(Opportunity opp:Trigger.New){
        accid.add(opp.AccountId);
         oppid.add(opp.id);
    }
    //select id,(Select productname,id from product) 
   List<Contract> cntrList= [select id,ContractNumber,StartDate from Contract where Account.id=:accid];
        List<Opportunity> oppList=[Select o.Name, (Select id,Quantity,Name From OpportunityLineItems),Pricebook2Id  From Opportunity o Where Id IN:oppid];
    if(Trigger.isinsert || Trigger.isUpdate){
        for(Opportunity oppNewObj:Trigger.New){
            if(oppNewObj.StageName=='Closed Won'){
                Order order=new Order();
                order.AccountId=oppNewObj.AccountId;
                order.EffectiveDate=cntrList.get(0).startDate;
                order.Status='draft';
                order.ContractId=cntrList.get(0).id;
                order.OrderReferenceNumber=oppNewObj.AccountId;  
                order.Pricebook2Id=oppList.get(0).Pricebook2Id;
                
                orderList.add(order);
                
                //OrderProduct od=new OrderProduct();
                
            }
            for(Opportunity oppoldObj:Trigger.old){
                if(oppNewObj.Amount!=oppoldObj.Amount){
                    accIdamntMap.put(oppNewObj.AccountId,oppNewObj.Amount);
                    
                }
            }
            
        }
        if(!accIdamntMap.isEmpty()){
            //List<Account> accList=[select id,SummOfOppamount__c from Account where id in :accIdamntMap.keySet()];
            //for(Account accObj:accList){
                //accObj.SummOfOppamount__c=accIdamntMap.get(accObj.id);
                //updatedList.add(accObj);
            //}
            
        }
        if(!updatedList.isEmpty()){
            update updatedList;
            
        }
        if(!orderList.isEmpty()){
            insert orderList;
           
            
        }
    }


}