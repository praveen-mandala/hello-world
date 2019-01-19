/*
Description : Test class for BootCampDay6Task1 Controller
Author: Praveen Goud
Date Of Creation: 14-07-2017
Last Modification: 14-07-2017
Modification History: null
*/
@IsTest
public class TestBOOTCAMPDAY6Task1REDO {
    
    @IsTest
    public static void testshowDetails() {
        BOOTCAMPDAY6Task1REDO bOOTCAMPDAY6Task1REDO = new BOOTCAMPDAY6Task1REDO();
        bOOTCAMPDAY6Task1REDO.showDetails();
        System.assert(bOOTCAMPDAY6Task1REDO.flag);
    }
}