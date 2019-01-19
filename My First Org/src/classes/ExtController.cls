public class ExtController {

    public static List<contact> conList{set;get;}
    public  String param1{set;get;}
    public static string accid='';
     public String name{set;get;}
     public String email{set;get;} 
    public String phone{set;get;}
     
    
    public ExtController(ApexPages.StandardSetController controller){
        
    }
    public ExtController(){
       System.debug(param1+ '---->'+accid);
        conList= [select Lastname,phone,email from Contact where id=:accid];
    
    }
    
    public  PageReference generatePDF() {
        //getDetails();
        return new PageReference('/apex/CreatePDF');
    }
    
 public PageReference  getDetails() {
   //  System.debug(param1);
     accid=param1;
        conList= [select Lastname,phone,email from Contact where id=:param1];
    name= conList.get(0).Lastname;
      email= conList.get(0).email;
      phone= conList.get(0).phone;
     //generatePDF();
      return new PageReference('/apex/CreatePDF');
     
        
    }    
}