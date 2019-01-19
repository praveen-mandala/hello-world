/*
Description : This Class is used to invoke CalculateTaxWS rest services
Author: Praveen Goud
Date Of Creation: 11-07-2017
Last Modification: 17-07-2017
Modification History: 1.getting the access token dynamically
					  2.Contructing the Json object
*/
public class CallWEBService {   
    
    public static final String username = 'prvngoud2@gmail.com';
    public static final String password = 'prvn!123';
    public static final String client_id = '3MVG9d8..z.hDcPLnN3qDSNaf4R_kKF5IH76esE_Us5vI0vSr1_f1UkkNKrdMxwP.u3g9km_BFgzZcYI.F69w';
    public static final String client_secret = '6212899092409512256';
    
    public String accessToken = '';
    
    //Getting the access token dynamically
    public CallWEBService(){
        
        String URI = 'https://login.salesforce.com/services/oauth2/token?grant_type=password&' + 'client_id=' + client_id + '&' + 'client_secret=' + client_secret + '&' + 'username=' + username + '&' + 'password=' + password;
        HttpRequest req = new HttpRequest();
        req.setEndpoint(URI);
        system.debug('URI-----'+URI);
        req.setMethod('POST');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        JSONParser jsnParser = JSON.createParser(res.getBody());
        //Parsing the Json to get the access token.
        while (jsnParser.nextToken() != null) {
            if ((jsnParser.getCurrentToken() == JSONToken.FIELD_NAME) && (jsnParser.getText() == 'access_token')){
                // Get the value.
                jsnParser.nextToken();
                accessToken = jsnParser.getText();
            }
        }
        System.debug('accessToken-->'+accessToken);
    }
    /*
    * Description : This method creates a Http request and invoke web service
	* return : Invoice Object
	*/
    public void getAllInfo() {
        //accessToken = '00D7F0000001C7Z!AQsAQB9Sf7FovsqSfs25OiBjwA_t9VZ8jc0TSbrzZ02VhyLDJFnb6U_T_lJam5EXoBjx5S7NGNnPaFWXGwr8Ya606uWvRLNe';
        String endpoint = 'https://ap5.salesforce.com/services/apexrest/getOrderInformation/';
        HttpRequest res = new HttpRequest();
        TestRest objGetToken=new TestRest();
        res.setHeader('Content-Type', 'application/json');
        res.setHeader('Authorization', 'Bearer ' + accessToken);        
        res.setMethod('POST');
        res.setBody('Hello Rest');
        res.setEndpoint(endpoint);
        Http http = new Http();
        HTTPResponse resp = http.send(res);
       	System.debug('response'+resp.getBody());
    }
}