trigger EventTri1 on Account (after insert) {

    Integer i =0;
    Event e1 = new Event();
    List<Event> eventList1 = new List<Event>();
    List<Account> eventList = trigger.New;
    for(Account e : eventList) {
       
        while(i<=10){
        //e1.OwnerId = e.OwnerId;
        e1.Subject = 'Subject';
        e1.StartDateTime = e.CreatedDate;
        e1.EndDateTime = e.CreatedDate;
        e1.WhatId = e.Id;
        eventList1.add(e1);
           
      i++;
        
    }
    }
    insert eventList1;
    
}