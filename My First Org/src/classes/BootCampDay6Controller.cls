public class BootCampDay6Controller {
    
    public String rec{set;get;}
    public List<Contact> con1{set;get;}
     public List<Contact> conList{set;get;}
    public boolean flag{set;get;}
    public PageReference deleteRecord() {
        System.debug(rec+' del');
        con1 = [Select Id,LastName  from Contact Where Id=:rec];
        delete con1;
        return new PageReference('https://c.ap5.visual.force.com/apex/TestJun30?core.apexpages.request.devconsole=1');
    }
    public PageReference editRecord() {
        flag=true;
        System.debug(rec);
        con1 = [Select Id,LastName from Contact Where Id=:rec];
        //delete con1;
        return new PageReference('/'+rec+'/e?retURL=%2F'+rec);
    }
    
    public PageReference saveRecord() {
        //flag=true;
        System.debug(rec);
        con1 = [Select Id,LastName from Contact Where Id=:rec];
        update con1;
        return new PageReference('/apex/BootCampDay6Task2?core.apexpages.request.devconsole=1');
    }
    
    
    public  BootCampDay6Controller() {	
        conList = [Select Id,LastName from Contact];
 
    }
    public BootCampDay6Controller(ApexPages.StandardController controller) {
    conList = [Select Id,LastName,Email,Phone from Contact];
   
}

}