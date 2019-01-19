trigger MaxTrigger on Contact (before insert , after update) {
    
    System.debug(MaxTriggerHandler1.checkflag);
    MaxTriggerHandler1 handler = new MaxTriggerHandler1();
    handler.run();
}