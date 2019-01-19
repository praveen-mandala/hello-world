public class TESTCS {
    
    public String LastName{set;get;}
    public String Email{set;get;}
    public String Phone{set;get;}
    public List<Contact> conList{set;get;}
    public List<Integer> orderList{set;get;}
    public List<String> feildList{set;get;}
    public TESTCS(ApexPages.StandardController controller){
    }
    public void testMeth() {
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
            system.debug('FieldName '+Integer.valueOf(mcs.get(se).Order__c));
            orderList.add(i);
            newMap.put(Integer.valueOf(mcs.get(se).Order__c), mcs.get(se).FieldName__c);
        }
        System.debug(orderList);
        Set<Integer> ss = newMap.keySet();
        system.debug('Keys '+ss);
        System.debug('orderList '+orderList);
        for(Integer j=1; j<ss.size()+1; j++) {
            searchField = newMap.get(j);
            if(searchField1 == ''){
                searchField1 +=searchField; 
            }
            else{
                searchField1 +=','+searchField;
            }
        }
        System.debug('searchField '+searchField1);
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
            }}
        System.debug('newMap '+newMap);
        System.debug('orderList '+orderList);
        for(Integer i=1;i<=orderList.size();i++) {
            feildList.add(newMap.get(i));
        }
        system.debug('feildList'+feildList);
        searchQuery += searchWhere; 
        system.debug(searchQuery);
        conList = Database.query(searchQuery);
        system.debug(conList);
    }
}