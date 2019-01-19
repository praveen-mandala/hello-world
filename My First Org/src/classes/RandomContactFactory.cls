public class RandomContactFactory {
    
    public static List<Contact> generateRandomContacts(INTEGER num , String lname){
        
        List<Contact> conList = new List<Contact>();
        for(INTEGER i=0; i<num ; i++){
			Contact c =  new Contact(FirstName='Test'+i,LastName='lname');
            conList.add(c);
        }
        insert conList;
        return conList;
    }

}