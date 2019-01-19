public class TESTCON {
    
    public List<Contact> conList = [Select Id,LastName,CreatedDate From Contact Where CreatedDate > :System.now().addHours(-2) and CreatedDate < :System.now().addHours(2)];
    public void test() {/*
        List<Log__c> logLst = new List<Log__c>();
        Integer count = 0;
        System.debug(count);
        DateTime d1 = System.now().addHours(-2);
        DateTime d2 = System.now().addHours(2);
        decimal hours = Math.Floor(
            (d2.getTime()  - d1.getTime())
            / (1000.0*60.0*60.0)
        );
        system.debug(hours);
        Log__c logObj = new Log__c();
        logObj.Record_Count__c = conList.size();
        logObj.Time_Interval_in_hours__c = hours;
        String sss = '';
        for(Contact ccc: conList) {
            sss += ccc.Id;
            sss += ',';
        }
        System.debug(sss);
        String newsss = sss.substring(0, sss.length()-1);
        logObj.Created_Records__c = newsss;
    
        insert logObj;*/
        //String query = 'Select Id,LastName,CreatedDate From Contact Where CreatedDate >';
          // query += ':System.now'+'('+')';
               //addHours(-2) and CreatedDate < :System.now().addHours(2)';
              Set<String> accNames = new Set<String>{ 'test','test me' };

String query = 'select id,name,(select id,ownerid from contacts) from account where CreatedDate < :System.now';
        query += '('+'	)';

System.debug(query);

System.debug(Database.query(query));
//String query = 'Select Id,LastName,CreatedDate From Contact Where CreatedDate > :System.now'+'('+')'+'.addHours'+'('+'-2'+')'+' and CreatedDate < :System.now'+'('+')'+'.addHours'+'('+'2'+')';
        
       // System.debug(query);
       
        //System.debug(Database.query(query));
        
        
    }    
    
}