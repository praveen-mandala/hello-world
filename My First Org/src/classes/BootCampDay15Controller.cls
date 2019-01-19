/*
Description : This is a controller class to create and insert Registration Object
Author: Praveen Goud
Date Of Creation: 12-07-2017
Last Modification: 12-07-2017
Modification History: null
*/
public class BootCampDay15Controller {
    
    public String Name{get;set;}
    public String Phone{get;set;}
    public String Email{get;set;}
    public String Gender{get;set;}
    
    /* Create Registration record
     * return : Page Reference to the detail page
     */
    
    public PageReference createRegistration() {
        Registration__c regObj = new Registration__c();
        regObj.Name = Name;
        regObj.Email__c = Email;
        regObj.Phone__c = Phone;
        regObj.Gender__c = Gender;
        insert regObj;
        return new PageReference('/'+regObj.Id);
    }
    
}