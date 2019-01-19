public class OptyRollUpAmountTriggerHelper {
    
    public static map<Id,Decimal> mapAccIdAndAmount = new Map<Id,Decimal>();
    public static void updateRollupOnAccount(List<Opportunity> lstOpp , Map<Id,Opportunity> mapOldOptys,Boolean IsInsert , Boolean IsDelete , Boolean IsUpdate ,Boolean IsUndelete) {
        for(Opportunity objOpp : lstOpp) {
            if(isUpdate) {
                System.debug('objOpp.TriggerAmount__c-->'+objOpp.TriggerAmount__c);
                System.debug('mapOldOptys.get(objOpp.Id).TriggerAmount__c-->'+mapOldOptys.get(objOpp.Id).TriggerAmount__c);
                if(mapAccIdAndAmount.containsKey(objOpp.AccountId))
                    mapAccIdAndAmount.put(objOpp.AccountId, mapAccIdAndAmount.get(objOpp.AccountId) + objOpp.TriggerAmount__c - mapOldOptys.get(objOpp.Id).TriggerAmount__c);
                else
                    mapAccIdAndAmount.put(objOpp.AccountId, objOpp.TriggerAmount__c - mapOldOptys.get(objOpp.Id).TriggerAmount__c);
            }
            else {
            if(mapAccIdAndAmount.containsKey(objOpp.AccountId))
                mapAccIdAndAmount.put(objOpp.AccountId, mapAccIdAndAmount.get(objOpp.AccountId) + objOpp.TriggerAmount__c);
            else
                mapAccIdAndAmount.put(objOpp.AccountId, objOpp.TriggerAmount__c);
            }
        }
        List<Account> lstAcc = [Select Id,TotalTriggerSalary__c from Account Where ID IN :mapAccIdAndAmount.keySet()];
        System.debug('lstAcc--'+lstAcc);
        
        System.debug('mapAccIdAndAmount-->'+mapAccIdAndAmount);
        for(Account objAcc : lstAcc) {
            //System.debug('objAcc.TotalTriggerSalary__c-->'+objAcc.TotalTriggerSalary__c);
            Decimal existingAmt = objAcc.TotalTriggerSalary__c == null ? 0 :objAcc.TotalTriggerSalary__c;
            if(IsInsert || IsUpdate || IsUndelete) {
                System.debug('existingAmt-->'+existingAmt);
                System.debug('mapAccIdAndAmount.get(objAcc.Id)-->'+mapAccIdAndAmount.get(objAcc.Id));
                objAcc.TotalTriggerSalary__c = existingAmt + mapAccIdAndAmount.get(objAcc.Id);
            }
            else if(IsDelete) {
                objAcc.TotalTriggerSalary__c = existingAmt - mapAccIdAndAmount.get(objAcc.Id);
            }
                
        }
        update lstAcc;
    }
    
}