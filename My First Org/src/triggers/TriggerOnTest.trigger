trigger TriggerOnTest on Test__c (after insert , after update) {
    
    List<Test__c> TestList = [Select Id,Stage__c,MDR__c from Test__c Where Id IN :Trigger.New];
    for(Test__c t : TestList) {
        
        if(t.Stage__c == 'New') {
            t.TestField__c = 'NewTest';
            System.debug(t.MDR__c);
            //t.MDR__c.Id = 0067F000002Is96;
        }
    }
    update TestList;

}