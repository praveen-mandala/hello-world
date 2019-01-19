/*
 Description : This Class is used to invoke DAY14Task1 rest services
 Author: Praveen Goud
 Date Of Creation: 11-07-2017
 Last Modification: 11-07-2017
 Modification History: null
*/
public class TestRest {
    Http http = new Http();
    String username = 'prvngoud2@gmail.com';
    String password = 'prvn!123450xGJLREJRgfCtZ8VeJEKwYXJq';
    String client_id = '3MVG9Y6d_Btp4xp40qfNb6B499B36Z7pYPyrGWtLUb3Rf674PQmt8iYy0vLsIN6BO.dl5lUVYemnosm2NJO_1';
    String client_secret = '7597666537141623646';
    String URI = 'https://login.salesforce.com/services/oauth2/token?grant_type=password&' + 'client_id=' + client_id + '&' + 'client_secret=' + client_secret + '&' + 'username=' + username + '&' + 'password=' + password;
    String accessToken = '';
    //Getting the access token dynamically
    public TestRest(){
        HttpRequest req = new HttpRequest();
        req.setEndpoint(URI);
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
    }
    
    public string GetToken()
    {
        return accessToken;
    }
    
    /*
     * Description : This method create a Http request and invoke web service
     * return : list of Contacts
    */
    public void testRestServices() {
        
        HttpRequest res = new HttpRequest();
        res.setHeader('Authorization', 'OAuth ' + accessToken);
        String endpoint = 'https://ap5.salesforce.com/services/apexrest/Account/0017F000005tvSq';
        res.setMethod('GET');
        res.setEndpoint(endpoint);
        Http http = new Http();
        HTTPResponse resp = http.send(res);
        System.debug(resp.getBody());   
    }
}