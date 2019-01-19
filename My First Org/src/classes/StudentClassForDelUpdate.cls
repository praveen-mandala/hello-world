/* Author Name   : Philips Dayan Pulipati
* Description    : Student information Search for Lightning 
* created Date   : 07 Nov 2017
* modified Date  : 07 Nov 2017
*/
public class StudentClassForDelUpdate {
    @AuraEnabled
    public static List < ConWrapper > fetchStudent (String searchboxstring) {
        String searchKey = searchboxstring + '%';
        List < ConWrapper > returnList = new List < ConWrapper > ();
        List < Contact > lstOfStudent = [select  id, LastName FROM Contact WHERE LastName LIKE : searchKey];
        System.debug('lstOfStudent-->'+lstOfStudent);
        for (Contact StudentObj: lstOfStudent) {
            ConWrapper obj = new ConWrapper();
            obj.check = false;
            obj.con = StudentObj;
            returnList.add(obj);
        }
        System.debug('returnList-->'+returnList);
        return returnList;
    }
    
    @AuraEnabled
    public static List < String > deleteRecords(List < String > lstRecordId) {
        // for store Error Messages  
        List < String > oErrorMsg = new List < String > ();
        // Query Records for delete where id in lstRecordId [which is pass from client side controller] 
        List < Contact > lstDeleteRec = [select Id from Contact where id IN: lstRecordId];
        system.debug('lstDeleteRec'+lstDeleteRec);
        delete lstDeleteRec;
        return null;
        /*Database.DeleteResult[] DR_Dels = Database.delete(lstDeleteRec, false);
        // Iterate through each returned result
        for (Database.DeleteResult dr: DR_Dels) {
            if (dr.isSuccess()) {
                // Operation was successful
            } else {
                // Operation failed, so get all errors   
                oErrorMsg.add('');
                for (Database.Error err: dr.getErrors()) {
                    // add Error message to oErrorMsg list and return the list
                    oErrorMsg.add(err.getStatusCode() + ': ' + err.getMessage());
                }
            }
        }
        return oErrorMsg;*/
    } 
    
    public class ConWrapper {
        @AuraEnabled
        public Boolean check;
        @AuraEnabled
        public Contact con;
    }
}