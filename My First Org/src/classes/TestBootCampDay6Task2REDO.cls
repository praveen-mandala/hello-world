/*
Description : Controller for BootCampDay6Task2
Author: Praveen Goud
Date Of Creation: 14-07-2017
Last Modification: 14-07-2017
Modification History: null
*/
@IsTest
public class TestBootCampDay6Task2REDO {
    
    @IsTest
    public static void testGetContacts() {
        BootCampDay6Task2REDO bootCampDay6Task2REDO =new BootCampDay6Task2REDO();
        bootCampDay6Task2REDO.Email = 'Test@test.com';
        bootCampDay6Task2REDO.Phone = '1234567';
        bootCampDay6Task2REDO.editRecord();
        bootCampDay6Task2REDO.deleteRecord();
        System.assertEquals('Test@test.com', bootCampDay6Task2REDO.Email);
    }
}