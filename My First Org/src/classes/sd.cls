public class sd {

    @future(callout=true)
    public static void callOrderAPI(String xmlBody , List<String> oppLst) {
        System.debug('Test');
		String endpoint = 'https://https.amazonsedi.com/eeccb213-452e-44a6-b89d-ddf1a50d8ebb';
        HttpRequest res = new HttpRequest();
        res.setMethod('POST');
        res.setEndpoint(endpoint);
        res.setBody(xmlBody);
        Http http = new Http();
        HTTPResponse resp = http.send(res);
        String response = resp.getBody();
        if(response.contains('200')) {
            List<Opportunity> oppRecLst = [Select Id,Description from Opportunity where ID IN :oppLst];
                for(Opportunity oppObj : oppRecLst) {
                    oppObj.Description = 'Order successfully placed in Amazon';
                }
            update oppRecLst;
        }
        
        /*if(response.contains('200'))
            return 'success';
        else
            return 'error'; */
    }
}