/*
Description : EmployeeIterator class is used to get the child set of records for pagination
Author: Praveen Goud
Date Of Creation: 19-07-2017
Last Modification: 21-07-2017
*/
global class EmployeeIterator implements Iterator<list<EventsWrapperClass>> {

    list<EventsWrapperClass> InnerList{get; set;}//holds the entire list of Employees
    list<EventsWrapperClass> ListRequested{get; set;}//holds only the required set of employees
    
    Integer i {get; set;} // Used to set the starting record
    public Integer setPageSize =0;
    public EmployeeIterator(List<EventsWrapperClass> lstAccWr)
   {
       InnerList = new list<EventsWrapperClass>(); 
       InnerList = lstAccWr;
       i = 0; 
   }
    //Return true if there are more records
    global boolean hasNext(){ 
       if(i >= InnerList.size()) {
           return false; 
       } else {
           return true; 
       }
   } 
   //Return true if there are previous records
   global boolean hasPrevious(){ 
       system.debug('I am in hasPrevious' + i);
       if(i <= setPageSize) {
           return false; 
       } else {
           return true; 
       }
   }
    /* 
     * Description : This method is called from Controller when next button is clicked
     * return : list of Next set of Employees
     */
    global list<EventsWrapperClass> next(){       
       system.debug('i value is ' + i);
       ListRequested = new list<EventsWrapperClass>(); 
       integer startNumber;
       integer size = InnerList.size();
       if(hasNext())
       {  
           if(size <= (i + setPageSize))
           {
               startNumber = i;
               i = size;
           }
           else
           {
               i = (i + setPageSize);
               startNumber = (i - setPageSize);
           }
           
           system.debug('i value is =====' + i);
           system.debug('i value is 2==== ' + (i - setPageSize));
           
           for(integer start = startNumber; start < i; start++)
           {
               ListRequested.add(InnerList[start]);
           }
       } 
       return ListRequested;
   }
    /* 
     * Description : This method is called from Controller when previous button is clicked
     * return : list of Previous set of Employees
     */
    global list<EventsWrapperClass> previous(){      
       ListRequested = new list<EventsWrapperClass>(); 
       system.debug('i value is previous before =====' + i);
       integer size = InnerList.size(); 
        System.debug('IIIII '+i);
       if(i == size)
       {
           if(math.mod(size, setPageSize) > 0)
           {    
               i = size - math.mod(size, setPageSize);
           }
           else
           {
               i = (size - setPageSize);
           } 
       }
       else
       {
           i = (i - setPageSize);
       }
       
       system.debug('i value is previous =====' + i);
       system.debug('i value is 2previous ==== ' + (i - setPageSize));
       
       for(integer start = (i - setPageSize); start < i; ++start)
       {
           ListRequested.add(InnerList[start]);
       } 
       return ListRequested;
   }
}