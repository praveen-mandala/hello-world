/*
* @Author               : Praveen M
* @Description          : trigger to invoke Ordering API
* @Date Of Creation     : 01-Nov-17
* @Modified by          : 
* @Modified Date        : 
* @Modifiction History  :
*/
trigger OrderTrigger on Opportunity (after update) {
    List<String> oppIdLst = new List<String>();
    Map<id,Opportunity> oppMap=Trigger.oldMap;
    for(Opportunity opp : Trigger.New) {
        if(opp.StageName == 'Purchased' && oppMap.get(opp.id).stageName!='Purchased') {
            oppIdLst.add(opp.Id);
        }
    }
    if(!oppIdLst.isEmpty())
        GetOpportunityProducts.getProductsandRole(oppIdLst);
}