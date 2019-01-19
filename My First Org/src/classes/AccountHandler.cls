public class AccountHandler {

    public static Account insertNewAccount(String name) {

        try{
        Account acc = new Account(Name = name);
        insert acc;
            ID accID = acc.Id;
            System.debug('Successfully inserted');
        Contact con = new Contact(LastName = 'LastName', AccountId = accID);
            insert con;
        return acc;
        }
        catch(DmlException e){

            system.debug('Error '+e.getMessage());
          return null;
        }
    }
}