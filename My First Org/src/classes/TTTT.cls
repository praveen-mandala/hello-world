public class TTTT {

    public static void display() {
       /* List<Account> accList = [Select id,Name from Account];
        Map<String ,Account> accountMap= new Map<String ,Account>();
        for()
        System.debug(accList);*/
        
        Map<Id ,Account> accountMap = new Map<Id ,Account>([Select id,Name from Account]);
       System.debug(accountMap);
    }
}