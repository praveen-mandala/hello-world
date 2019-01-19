/*trigger RestrictContactByName on Contact (before insert , before update) {
    

    List<Contact> conList = new List<Contact>();
    List<Contact>conList = [SELECT ID FROM Contact WHERE LastName='INVALIDNAME' AND ID IN :Trigger.Old];
    for(Contact c : conList){

        Trigger.OldMap.get(c.Id).addError('Cannot add Contact');
    }
}*/
trigger RestrictContactByName on Contact (before insert, before update) {
    
    //check contacts prior to insert or update for invalid data
    For (Contact c : Trigger.New) {
        if(c.LastName == 'INVALIDNAME') {   //invalidname is invalid
            c.AddError('The Last Name "'+c.LastName+'" is not allowed for DML');
        }

    }



}