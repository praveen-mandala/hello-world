/*
Description : Test class for DAY10Task2 
Author: Praveen Goud
Date Of Creation: 07-07-2017
Last Modification: 07-07-2017
Modification History: 
*/
@IsTest
public class TESTDAY10Task2 {

    @IsTest
    public static void testGetFields() {
		DAY10Task2 dAY10Task2 = new DAY10Task2();
        createContactUtilty();
        dAY10Task2.selectedOption = 'TTT';
        dAY10Task2.getFields();
        dAY10Task2.getRecords();
        dAY10Task2.getPickListValues();
        dAY10Task2.getChildRelatedLists();
        dAY10Task2.display();
    }
    
    public static void createContactUtilty() {
        List<Contact> conList =  new List<Contact>();
        for(Integer i=0 ;i<10 ; i++) {
        Contact c = new Contact();
        c.LastName='Test'+i;
        c.Phone = '1223444';
 		conList.add(c);
        }
        insert conList;
    }
}