/*
 Description : Boot Camp Day4 Task
 Author: Praveen Goud	
 Date Of Creation: 27-06-2017
 Last Modification: 28-06-2017
 Modification History: null
 */
public class BootCampDay2 {
  /*
     Description: This method will send an Email to Contacts whose Lead source is changed.	
	 param : accId - Id of Account
  */
  public static void getMap(String accId) {
    List<Contact> conList = getContacts(accId); 
    for(Contact c : conList) {
      c.LeadSource = 'Other';
    }
    try {
      update conList;
    }
    catch(Exception e) {
      e.getMessage();
    }
    sendEmail(conList);
  }
  /*
     Description: This method will update the Mailing address of Contact with Shipping Address of Account.	
	 param : accId - Id of Account
  */
  @TestVisible
  private static void method2(String accId) {
    List<Contact> conList = getContacts(accId);
	Account acc = [Select Id,ShippingAddress,ShippingCity,ShippingCountry,ShippingPostalCode,ShippingState,ShippingStreet from Account where Id=:accId].get(0);
      for(Contact c : conList) {
        if(c.MailingCity.equals(acc.ShippingCity) && c.MailingCountry.equals(acc.ShippingCountry)
           && c.MailingState.equals(acc.ShippingState)) {
          c.LeadSource='Web';  
        }
        else {
          c.MailingCity = acc.ShippingCity;
          c.MailingCountry = acc.ShippingCountry;
          c.MailingPostalCode = acc.ShippingPostalCode;
          c.MailingState = acc.ShippingState;
          c.MailingStreet = acc.ShippingStreet;
          c.LeadSource='Web';
        }
      }
      try{
        update conList;
      }
      catch(Exception e){
        e.getMessage();
      }
  }
  /*
     Description: This method is Utility method to return List of Contacts 	
	 param : accId - Id of Account
	 return : List of Contacts.
  */
  private static List<Contact> getContacts(String accId) {
    return [Select Id,Account.Id,LeadSource,Email,MailingAddress,MailingCity,MailingCountry,MailingPostalCode,MailingState,MailingStreet From Contact Where AccountId=:accId];
  }
  /*
     Description: This method will send emails.	
	 param : conList - List of Contacts.
  */
  private static void sendEmail(List<Contact> conList) {
    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
    for(Contact c : conList) {
      if(c.Email!=null) {
      	 Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
         List<String> mailAddresses = new List<String>();
         mailAddresses.add(c.Email);
      	 mail.setToAddresses(mailAddresses);
         mail.setSubject('Contacts Updated!');
         String body = 'Dear '+c.FirstName;
         body += 'Field Updated.';
         body += 'Lead Source '+c.LeadSource;
         mail.setHtmlBody(body);
         mails.add(mail);
      }
      Messaging.sendEmail(mails);
    }
  }  
}