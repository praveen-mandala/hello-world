/*
Description : Apex rest service to calculate tax on Amount in Invoice Object.
Author: Praveen Goud
Date Of Creation: 11-07-2017
Last Modification: 17-07-2017
Modification History: 1.Parsing the Json object to get the amount
					  2.Returning the tax after serializing.
*/
@RestResource(urlMapping='/InvoiceTax/*')
global class CalculateTaxWS {
    
	/*
	* Description : HttpPost method to return list tax on amount
	* return : Tax
	*/
    @HttpPost
    global static String calculateTax1() {
        RestRequest request = RestContext.request;
        JSONParser jsnParser = JSON.createParser(request.requestBody.toString());
        System.debug('jsnParser '+jsnParser);
        Decimal amount = 0;
        Decimal tax = 0;
        //Parsing the Json and getting the Amount
        while (jsnParser.nextToken() != null) {
            if ((jsnParser.getCurrentToken() == JSONToken.FIELD_NAME) && (jsnParser.getText() == 'Amount')){
                // Get the value
                jsnParser.nextToken();
                System.debug(jsnParser.getText());
                amount = Double.valueOf(jsnParser.getText());
            }
        }
        if(amount == 0){
            return Json.serialize(tax);
        }
        else if(amount < 500) {
            tax = (5*amount)/100; 
        }
        else{tax = (10*amount)/100;}
        return Json.serialize(tax);
    }
}