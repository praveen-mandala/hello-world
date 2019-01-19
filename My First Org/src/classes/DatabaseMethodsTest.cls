public class DatabaseMethodsTest {

    public static void MethTest() {

        //List l = new List{'a','b','c'};
        List<Contact> conList = new List<Contact>{new Contact(LastName='abc1'),new Contact(LastName='abc2'),new Contact()};
    	Database.SaveResult[] saveList  = Database.insert(conList	, false);
        for(Database.SaveResult sr : saveList) {

            if(sr.isSuccess()){
                
                System.debug('Success');
            }
            else
                System.debug('Failed');
        }
    }
}