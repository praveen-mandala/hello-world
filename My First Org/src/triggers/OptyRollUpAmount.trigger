trigger OptyRollUpAmount on Opportunity (after insert , after update , after delete , after undelete) {

    if(trigger.isInsert) {
        OptyRollUpAmountTriggerHelper.updateRollupOnAccount(trigger.New ,null , true ,false , false ,false);
    }
    if(trigger.isDelete) {
        OptyRollUpAmountTriggerHelper.updateRollupOnAccount(trigger.Old ,null, false , true , false,false);
    }
    if(trigger.isUpdate) {
        OptyRollUpAmountTriggerHelper.updateRollupOnAccount(trigger.New , trigger.OldMap , false , false , true,false);
    }
    if(trigger.isUndelete) {
        OptyRollUpAmountTriggerHelper.updateRollupOnAccount(trigger.Old ,null, false , false , false , true);
    }
}