@RestResource(urlMapping='/restservice/*')
global with sharing class MyOwnTypeRestResource {

    @HttpPost
    global static Contact myContact() {
    
        RestRequest req = RestContext.request;
        Blob body = req.requestBody;
        Map<String,String> params = req.params;
        System.debug('params-->'+params);
        String requestString = body.toString();
        //HttpRequest req = new HttpRequest();
        //String str = req.getBody();
        System.debug(requestString);
        Contact con = new Contact();
        con.LastName = requestString;
        insert con;
        return con;
    }

    @HttpGet
    global static Contact getContact() {
    
        return [select id, name from contact limit 1];
    }
    
}