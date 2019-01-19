public class GenerateXMLResponse {
    //public string xmlstring;
    public static string successXMLgen(){
        string xmlstring;
        DOM.Document doc = new DOM.Document();
 
        dom.XmlNode success = doc.createRootElement('Response', null, null);
        dom.XmlNode body1= success.addChildElement('status', null, null);
 
        body1.addChildElement('Message', null, null).addTextNode('Success');
        xmlstring = doc.toXmlString();
        system.debug('--->'+xmlstring);
        return xmlstring;
        
    }
    public static string failureXMLgen(){
        string xmlstring;
        DOM.Document doc = new DOM.Document();
 
        dom.XmlNode Failed = doc.createRootElement('Response', null, null);
        dom.XmlNode body1= failed.addChildElement('status', null, null);
 
        body1.addChildElement('Message', null, null).addTextNode('failed');
        xmlstring = doc.toXmlString();
        system.debug('--->'+xmlstring);
        return xmlstring;
        
    }
}