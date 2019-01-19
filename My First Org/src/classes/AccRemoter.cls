/*
Description : Controller class 
Author: Praveen Goud
Date Of Creation: 03-07-2017
Last Modification: 03-07-2017
Modification History: 
*/
public class AccRemoter {

    @RemoteAction
    public static List<Contact> getContacts1(String name) {
        List<Contact> ConList = [SELECT Id, LastName ,Email,Phone
                   FROM Contact Where LastName like :name+'%'];
        return conList;
    }
}