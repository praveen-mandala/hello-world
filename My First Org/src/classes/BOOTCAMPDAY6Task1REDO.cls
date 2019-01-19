/*
Description : Controller for BootCampDay6Task1
Author: Praveen Goud
Date Of Creation: 14-07-2017
Last Modification: 14-07-2017
Modification History: null
*/
public class BOOTCAMPDAY6Task1REDO {
    public List<Account> accList{get;set;}
    public boolean flag{get;set;}
    public BOOTCAMPDAY6Task1REDO() {
        accList = [Select Id,Name From Account Where Phone != ''];
    }
    
    public void showDetails() {
        flag=true;
    }
}