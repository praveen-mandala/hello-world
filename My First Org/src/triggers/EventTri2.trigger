trigger EventTri2 on Account (after insert) {

    Integer i =0;
    
    List<Event> eventList1 = new List<Event>();
    List<Account> eventList = trigger.New;
   // for(Account e : eventList) {
      
    Account e =  EventList.get(0);
        while(i<=10){
 
            Event e1 = new Event();
        //e1.OwnerId = e.OwnerId;
        e1.Subject = 'Subject'+i;
        e1.StartDateTime = e.CreatedDate;
        e1.EndDateTime = e.CreatedDate;
        e1.WhatId = e.Id;
        eventList1.add(e1);
        i++;
        
    }
    //}
    upsert eventList1;
    
}