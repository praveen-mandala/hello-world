public class TESTWSS {

    
    String username = 'prvngoud2@gmail.com';
    String password = 'prvn!123450xGJLREJRgfCtZ8VeJEKwYXJq';
    String client_id = '3MVG9d8..z.hDcPLnN3qDSNaf4R_kKF5IH76esE_Us5vI0vSr1_f1UkkNKrdMxwP.u3g9km_BFgzZcYI.F69w';
    String client_secret = '6212899092409512256';
    String URI = 'https://login.salesforce.com/services/oauth2/token?grant_type=password&' + 'client_id=' + client_id + '&' + 'client_secret=' + client_secret + '&' + 'username=' + username + '&' + 'password=' + password;
    
    String accessToken = '';
    
    public TESTWSS(){
        HttpRequest req = new HttpRequest();
        req.setEndpoint(URI);
        req.setMethod('POST');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug('*** After Authentication...'+res.getBody());
        JSONParser jsnParser = JSON.createParser(res.getBody());
        while (jsnParser.nextToken() != null) {
            if ((jsnParser.getCurrentToken() == JSONToken.FIELD_NAME) && (jsnParser.getText() == 'access_token')){
                jsnParser.nextToken();
                accessToken = jsnParser.getText();
            }
        }
        System.debug(accessToken);
    }
}