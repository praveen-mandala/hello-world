public class SendEmailMessage {
    Public static void SendEmail(string xmlres)
    {
         Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
                String[] toAddresses = new list<string> {'devorg@cloudnerd.com','chandu@cloudnerd.com'};
                String subject ='The Amazon order response xml Status';
                email.setSubject(subject);
                email.setToAddresses( toAddresses );
                email.setPlainTextBody('This is a system generated message, \n\nThe Amazon order response xml is \n\n.'+xmlres);
                Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    }
}