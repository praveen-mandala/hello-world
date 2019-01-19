public class TTTTTTTTTTTTTTTTTTTT {

    
    
    public String LastName{set;get;}
    public String Email{set;get;}
    public String Phone{set;get;}
    public List<Contact> conList{set;get;}
    public List<Integer> orderList{set;get;}
    public List<String> feildList{set;get;}
    
    public void prepareSearchQuery() {
        orderList = new List<Integer>();
        feildList = new List<String>();
        String searchField='';
        String searchField1='';
        String searchQuery='SELECT ';
        Map<String, ExampleCS__c> mcs = ExampleCS__c.getAll();
        Map<Integer , String> newMap = new Map<Integer , String>();
        Set<String> s = mcs.keySet();
        for(String se : s ){
            Integer i =Integer.valueOf(mcs.get(se).Order__c);
            orderList.add(i);
            newMap.put(Integer.valueOf(mcs.get(se).Order__c), mcs.get(se).FieldName__c);
        }
        system.debug(newMap);
        Set<Integer> ss = newMap.keySet();
        List<Integer> sortList=new List<Integer>(ss);
        sortList.sort();
       
        
        for(Integer si :sortList) {
            searchField = newMap.get(si);
            if(searchField1 == ''){
                searchField1 +=searchField; 
            }
            else{
                searchField1 +=','+searchField;
            }
        }
        searchQuery +=searchField1;
        searchQuery +=' FROM Contact';
        String searchWhere='';
        if(LastName != '' || Phone != '' || Email != ''){
            searchWhere +=' WHERE';
            if(LastName !=null && LastName != ''){
                if(searchWhere != ' WHERE'){
                    searchWhere += ' AND LastName=:LastName';
                }
                else{searchWhere += ' LastName=:LastName';}
            }
            if(Phone !=null && Phone !=''){
                if(searchWhere != ' WHERE'){
                    searchWhere += ' AND Phone=:Phone';
                }
                else{searchWhere += ' Phone=:Phone';}
            }
            if(Email !=null && Email !=''){
                if(searchWhere != ' WHERE'){
                    searchWhere += ' AND Email=:Email'; 
                }
                else {searchWhere += ' Email=:Email';}
            }
        }
        /*for(Integer i=1;i<=orderList.size();i++) {
            feildList.add(newMap.get(i));
        }*/
        system.debug(searchField1);
        feildList = searchField1.split(',');
        system.debug(feildList);
        searchQuery += searchWhere; 
        system.debug(searchQuery);
        conList = Database.query(searchQuery);
    }

}