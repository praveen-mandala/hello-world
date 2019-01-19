public class TESTDUp {

	    public List<sObject> scope = [Select Id,Email,LastName,(Select Id From Cases) From Contact];
    	public void test(){
           List<Contact> contactList = new List<Contact>();
                List<Case> caseList = new List<Case>();
        Map<Id,Contact> deleteMap = new Map<Id,Contact>();
        Map<Id,List<Case>> deleteCases = new Map<Id,List<Case>>();
        /*for(sObject sobj : scope) {
           contactList.add((Contact)sobj);
        }*/
            contactList = scope;
            System.debug('Hello');
            System.debug(contactList);
        for(Contact con : contactList) {
            if(con.Email !=''){
            for(Contact con1 : contactList) {
                if(con.Id != con1.Id && con.Email == con1.Email) {
                    if(con1.Cases.size()!=0 && !deleteCases.containsKey(con1.Id)){deleteCases.put(con1.Id, con1.Cases);}
                    if(con.Cases.size()!=0 && !deleteCases.containsKey(con.Id)){deleteCases.put(con.Id, con.Cases);}
                    if(!deleteMap.containsKey(con1.Id)) {
                        deleteMap.put(con1.Id, con1);
                    }
                    if(!deleteMap.containsKey(con1.Id)) {
                        deleteMap.put(con1.Id, con1);
                    }
                }
                }
                
            }
            
        }
        system.debug(deleteMap.values());
        //System.debug(deleteCases.values());
        
        for(Id cc : deleteCases.keySet()) {
            caseList.addAll(deleteCases.get(cc));
        }
        System.debug(caseList);
        
        delete caseList;
        delete deleteMap.values();
        
        
    }

}