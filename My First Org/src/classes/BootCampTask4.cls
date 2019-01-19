public class BootCampTask4 {

    public void createMap() {
        Map<Id,Account> accMap = new Map<Id,Account>([SELECT Id,(Select Id,LastName,Email from Contacts) From Account]);
    }
    
   
}