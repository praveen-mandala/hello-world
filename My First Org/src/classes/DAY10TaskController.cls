/*
Description : Get the list of records with the matching search string(Controller). 
Author: Praveen Goud
Date Of Creation: 05-07-2017
Last Modification: 06-07-2017
Modification History: 
*/
public class DAY10TaskController {
    
    public String LastName{set;get;}
    public String Email{set;get;}
    public String Phone{set;get;}
    public List<Contact> conList{set;get;}
    public List<String> feildList{set;get;}
    
    /*
    Description : This Method is used to build the Search query using Dynamic SOQL.
    */
    public void prepareSearchQuery() {
        feildList = new List<String>();
        String searchField='';
        String searchField1='';
        String searchQuery='SELECT ';
        Map<String, ExampleCS__c> mcs = ExampleCS__c.getAll();
        Map<Integer , String> newMap = new Map<Integer , String>();
        Set<String> s = mcs.keySet();
        for(String se : s ){
            Integer i =Integer.valueOf(mcs.get(se).Order__c);
            newMap.put(Integer.valueOf(mcs.get(se).Order__c), mcs.get(se).FieldName__c);
        }
        Set<Integer> ss = newMap.keySet();
        List<Integer> sortList=new List<Integer>(ss);
        sortList.sort();//Sorting the keys.
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
        feildList = searchField1.split(',');//spliting searchField1 to get values in order
        searchQuery += searchWhere;
        conList = Database.query(searchQuery);
    }
    
}