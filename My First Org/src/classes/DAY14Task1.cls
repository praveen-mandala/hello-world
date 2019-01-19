/*
 Description : Apex rest service to return list of Contacts related to an Account.
 Author: Praveen Goud
 Date Of Creation: 11-07-2017
 Last Modification: 11-07-2017
 Modification History: null
*/
@RestResource(urlMapping='/Account/*')
global class DAY14Task1 {
    
    /*
     * Description : HttpGet method to return list of Contacts related to an Account
     * return : list of Contacts
    */
    
	@HttpGet
    global static String doGet() {
        RestRequest request = RestContext.request;
        String accId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        List<Contact> conList = [Select Id From Contact Where AccountId= :accId]; 
        return Json.serialize(conList);
    }
    
    
    
}