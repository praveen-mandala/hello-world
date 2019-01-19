/*
Description : This is the Test class for AssignEmployeestoEventController
Author: Praveen Goud
Date Of Creation: 21-07-2017
Last Modification: 21-07-2017
*/
@IsTest
public class TestAssignEmployeestoEventController {
    
    
    @IsTest
    public static void testFillEventwithNoId() {
        AssignEmployeestoEventController objEmpToEvent = new AssignEmployeestoEventController();
        objEmpToEvent.createRecords();
        objEmpToEvent.hasNext=true;
        objEmpToEvent.hasPrevious =false;
        System.assertEquals(false, objEmpToEvent.hasPrevious);
        System.assertEquals(false, objEmpToEvent.hasNext);
    }
    @IsTest
    public static void testGetDetails() {
        AssignEmployeesUtility utilityObj = new AssignEmployeesUtility();
        utilityObj.createDependentRecords();
        AssignEmployeestoEventController objEmpToEvent = new AssignEmployeestoEventController();
        objEmpToEvent.createRecords();
        objEmpToEvent.hasNext=true;
        objEmpToEvent.hasPrevious =false;
    }
    
}