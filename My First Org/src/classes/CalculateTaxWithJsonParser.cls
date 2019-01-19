@RestResource(urlMapping='/InvoiceTax1/*')
global class CalculateTaxWithJsonParser {

    /*
     * Description : HttpPost method to return list tax on amount
     * return : Tax
    */
    @HttpPost
    global static Decimal calTax() {
        RestRequest request = RestContext.request;
        invoice__C cc= (Invoice__c)JSON.deserialize(request.requestBody.toString(), Invoice__c.class);
        System.debug(cc.Name);
        Decimal amount = cc.Amount__c;
        Decimal tax = 0;
        if(amount == 0){
            return tax;
        }
        if(amount < 500) {
            tax = (5*amount)/100; 
        }
        else{tax = (10*amount)/100;}
        return tax;
    }
}