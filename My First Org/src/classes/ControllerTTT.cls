/*
Description : Extension Controller for DAY6BOOTCAMPTASK1
Author: Praveen Goud
Date Of Creation: 29-06-2017
Last Modification: 30-06-2017
Modification History: null
*/
public class ControllerTTT {
    public String param{set;get;}
    public Boolean flag{set;get;}
    public ControllerTTT(ApexPages.StandardSetController controller){
    }
    public PageReference getDetails() {
        flag=true;
        Account acc = [select Id,Name from Account where Id=:param].get(0);
        PageReference pr = new PageReference('/apex/DAY6BOOTCAMPTASK1?id='+param);
        return pr;
    }
}