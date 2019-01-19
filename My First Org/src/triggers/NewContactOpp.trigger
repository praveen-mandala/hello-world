trigger NewContactOpp on Contact (after insert) {

    System.debug('In Opp');
    Opportunity opp = new Opportunity();
    opp.Name = 'Test';
    opp.Discount_Percent__c = 0.30;
    opp.CloseDate =  DATE.today();
    opp.StageName = 'Qualification';
    System.debug(opp.Name);
    insert opp;
}