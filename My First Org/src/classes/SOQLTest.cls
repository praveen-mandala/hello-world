public class SOQLTest {

    public static void Test() {
   
        AggregateResult[] result = [SELECT Type,AVG(AnnualRevenue) FROM Account GROUP BY Type];
        
        for(AggregateResult ar : result) {

            System.debug('Type '+ar.get('Type')+' Avg Amt '+ar.get('expr0'));
            
        }
    }
}