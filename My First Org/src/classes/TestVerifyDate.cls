@isTest
private class TestVerifyDate {

   
    @isTest static void test() {
      VerifyDate.CheckDates(Date.today(), Date.today());
       
    }
    
     @isTest static void test1() {
        Date d = Date.today();
      VerifyDate.CheckDates(Date.today(), d.addDays(40));
       
    }
}