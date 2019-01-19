public class ContactAndLeadSearch {

    public static List<List<sObject>> searchContactsAndLeads(String name){
       
        
        //List<List<SObjects>> obj1 = [FIND ':name' IN NAME FIELDS RETURNING Contact(ID),Lead(ID)];
        //return obj1;
        
        List<List<sObject>> searchList = [FIND :name IN NAME FIELDS 
                   RETURNING Contact(ID),Lead(ID)];
        
       /* for(list<SObject> li : searchList) {

           Contact con = (Contact)li[0];
           Lead lead = (Lead)li[1];
           System.debug(con.FirstName+' '+con.LastName);
            System.debug(lead.LastName);
            
        }*/
        
        return searchList;

    }
}