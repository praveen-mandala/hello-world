/*
Description : This is the Utility class which prepares all the required test records
Author: Praveen Goud
Date Of Creation: 21-07-2017
Last Modification: 21-07-2017
*/
public class AssignEmployeesUtility {
    
    public id insertCompany(){
        Company__c objComp =  new Company__c();
        objComp.Name = 'TestCompany';
        objComp.City__c = 'Hyd';
        objComp.Country__c = 'Ind';
        insert objComp;
        return objComp.id;
    }
    public id insertEmployee(id cmpId){
        Employee__c objEmp = new Employee__c();
        objEmp.Name = 'TestEmp';
        objEmp.Company__c = cmpId;
        objEmp.Email__c = 'Test@Test.com';
        objEmp.Mobile__c = '123456789';
        insert objEmp; 
        return objEmp.id;
    }
    public id insertEvent(id cmpId){
        Event__c objEve = new Event__c();
        objEve.Name = 'TestEvent';
        objEve.Company__c = cmpId;
        objEve.Hosted_By__c = 'TestHost';
        objEve.Coordinated_By__c = 'TestCoordinator';
        insert objEve;
        return objEve.id;
    }
    public id insertEvntAttendees(id evntid,id empid){
        Event_Attendees__c attendeesObj = new Event_Attendees__c();
        attendeesObj.Event__c =  evntid;
        attendeesObj.Employee__c = empid;
        attendeesObj.Participation_Type__c = 'Host';
        insert attendeesObj;
        return attendeesObj.id; 
    }
    public void createDependentRecords(){
        id cmpid=insertCompany();
        id empId=insertEmployee(cmpid);
        id evntId=insertEvent(cmpid);
        id evntattid=insertEvntAttendees(evntId,empId);
        ApexPages.currentPage().getParameters().put('Id',evntId);
        insertEmployee(cmpid);
    }
    
}