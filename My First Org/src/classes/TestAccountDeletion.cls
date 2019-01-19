@IsTest
private class TestAccountDeletion {

    @IsTest static void Test() {

        Account acc = new Account(Name='bbbb');
        insert acc;
        Opportunity opp = new Opportunity(Name = 'oppBBB',StageName='Prospecting',CloseDate=System.today().addMonths(1),AccountId = acc.Id);
        insert opp;
        Test.startTest();
        Database.DeleteResult del = Database.delete(opp , false);
        Test.stopTest();
        
       System.assert(del.isSuccess());
        //System.assert(del.getErrors().size()>0);
        //System.assertEquals('cannot delete', del.getErrors()[0].getMessage());
    }
}