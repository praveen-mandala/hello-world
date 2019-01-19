/*
Description : This is a test class for BootCampDay15Controller
Author: Praveen Goud
Date Of Creation: 12-07-2017
Last Modification: 12-07-2017
Modification History: null
*/
@IsTest
public class TESTBootCampDay15Controller {
    
    @IsTest
    public static void testCreateRegistration() {
        BootCampDay15Controller bootCampDay15Controller = new BootCampDay15Controller();
        bootCampDay15Controller.Name = 'Test';
        bootCampDay15Controller.Email = 'Test@test.com';
        bootCampDay15Controller.Gender = 'Male';
        bootCampDay15Controller.Phone = '12334555';
        bootCampDay15Controller.createRegistration();
        System.AssertEquals('Test',bootCampDay15Controller.Name);
    }
}