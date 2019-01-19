trigger SendConfirmationEmail on Session__c (after insert , after update) {

    List<Session_Speaker__c> sesList = [SELECT Session__r.Id,Speaker__r.Email__c FROM Session_Speaker__c WHERE Session__r.Id IN :Trigger.New];
    
    for(Session_Speaker__c ssc: sesList) {
        
        String mail = ssc.Speaker__r.Email__c;
        if(mail != null)
        {EmailManager.sendMail(mail, 'Session assigned', 'Success');}
    }
}