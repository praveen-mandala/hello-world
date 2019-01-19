/*
Description : Test class for DAY9SOSLController 
Author: Praveen Goud
Date Of Creation: 04-07-2017
Last Modification: 04-07-2017
Modification History: 
*/
@IsTest
public class TestDAY9SOSLController {
    
    @IsTest
    public static void testgetRecords() {
        DAY9SOSLController obj = new DAY9SOSLController();
        obj.getRecords();
    }
    @IsTest
    public static void testgetRecords1() {
        DAY9SOSLController obj = new DAY9SOSLController();
        obj.searchText = 'TEST';
        Account ac =  new Account();
        ac.Name = 'TTTESTTT';
        insert ac;
        obj.accList.add(ac);
        obj.getRecords();
    }
}