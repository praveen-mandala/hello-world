/*
Description : Controller for BootCampDay6Task2
Author: Praveen Goud
Date Of Creation: 14-07-2017
Last Modification: 14-07-2017
Modification History: null
*/
public class BootCampDay6Task2REDO {
    public List<Contact> conList{get;set;}
    public String Email{get;set;}
    public String Phone{get;set;}
    
    public BootCampDay6Task2REDO() {
        conList = [Select Id,LastName,Phone From Contact];
    }
    //This Method is called when edit is clicked
    public void editRecord() {
        update conList;
    }
    //This method is called to delete record
    public void deleteRecord() {
        String recId;
        conList.clear();
        recId = ApexPages.currentPage().getParameters().get('recId');
        if(recId != null && recId != '') {
            Contact con1 = [Select Id,LastName,Phone From Contact Where Id=:recId Limit 1];
            delete con1;
        }
        conList = [Select Id,LastName,Phone From Contact];
    }
}