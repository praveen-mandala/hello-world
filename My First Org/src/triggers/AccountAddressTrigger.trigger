trigger AccountAddressTrigger on Account (before insert , before update) {

    System.debug('111111');
    
    for(Account a : Trigger.New) {
    
        Boolean b = a.Match_Billing_Address__c;
        system.debug(b);
        String c = a.BillingPostalCode;
        System.debug(c);
        if(b)
        {

            System.debug('in if');
            if(c.equals(null)){
                
            }
            else{

                system.debug('in else');
                a.ShippingPostalCode = c;
                system.debug(a.ShippingPostalCode);
            }
        }
        System.debug('updating');
        //update a;
        
       
    }
}