public class CreateOptyForCaseCntrl {
    
    public String caseId{get;set;}//To Store the Case Id.
    public CreateOptyForCaseCntrl(ApexPages.StandardController controller) {
        System.debug('Constructor');
        caseId = controller.getId();
    }
    
    public PageReference createNewOpty() {
        Case caseObj = [Select Id,AccountId,Account.Name,Subject,CaseOpty__c from Case where Id = :caseId];
        System.debug('caseObj-->'+caseObj.CaseOpty__c);
        if(caseObj.CaseOpty__c == null) {
            System.debug('createNewOpty-->'+caseObj);
            Opportunity opp = new Opportunity();
            opp.Name = 'Testing Case Opty';
            opp.Type = 'New Customer';
            opp.Amount = 1234;
            opp.CloseDate = System.today();
            opp.StageName = 'Active';
            insert opp;
            caseObj.CaseOpty__c = opp.Id;
            upsert caseObj;
        }
        return new PageReference('/'+caseObj.Id);
    }
}