trigger ClosedOpportunityTrigger on Opportunity (after insert , after update) {
    
    List<Task> taskList = new List<Task>();
    List<Opportunity> oppList = [SELECT id,Name From Opportunity WHERE StageName = 'Closed Won' AND ID IN :Trigger.New];
    For(Opportunity Opp : oppList){
        System.debug(Opp);
        Task t = new Task();
        t.WhatId = opp.Id;
        t.Subject = 'Follow Up Test Task';
        t.Status = 'Completed';
        t.Priority = 'High';
        system.debug(t);
        taskList.add(t);
    }

    if(taskList.size()>0){
        insert taskList;}
}