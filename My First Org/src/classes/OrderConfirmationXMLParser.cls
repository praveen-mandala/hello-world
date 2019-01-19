/*
* @Author               : Gopinadh 
* @Description          : Order Confirmation parsing class
* @Date Of Creation     : 13-Oct-17
* @Modified by          : Gopinadh 
* @Modified Date        : 27-Dec-2017
* @Modifiction History  :
*/
public class OrderConfirmationXMLParser {
    //public string Orderid='';
    public static string ParseOrderConfirmation(string OrdCnfResponse)//string OrdCnfResponse
    {
        
        try
        {
            string response = OrdCnfResponse;
            system.debug('OrdCnfResponse--->'+OrdCnfResponse);
            SendEmailMessage sem = new SendEmailMessage();
            sem.SendEmail(OrdCnfResponse);
            OrderConfirmDetails ocd = new OrderConfirmDetails();
            //string response = '<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE cXML SYSTEM "http://xml.cxml.org/schemas/cXML/1.2.024/Fulfill.dtd"><cXML payloadID="1514368545061.134.9588@amazon.com" timestamp="2017-12-27T09:55:45+0000" xml:lang="en-US"><Header><From><Credential domain="NetworkId"> <Identity>Amazon</Identity></Credential></From><To><Credential domain="NetworkId">   <Identity>SupplyTheTeachers7886716302</Identity> </Credential> </To><Sender><Credential domain="NetworkId"><Identity>Amazon</Identity><SharedSecret>password</SharedSecret></Credential><UserAgent>Amazon LLC eProcurement Application</UserAgent></Sender></Header><Request><ConfirmationRequest><ConfirmationHeader operation="new" type="detail" noticeDate="2017-12-27T09:55:45+0000"/><OrderReference orderID="AEOID-19" orderDate="2017-12-27T15:25:20Z"></OrderReference><ConfirmationItem quantity="2" lineNumber="1"><UnitOfMeasure>EA</UnitOfMeasure><ConfirmationStatus quantity="2" type="reject"><UnitOfMeasure>EA</UnitOfMeasure><Comments type="LineItemErrorCode_222">The item was successfully processed in Test mode. However, the order was not shipped and you were not charged, since it was placed in Test mode.</Comments></ConfirmationStatus></ConfirmationItem><ConfirmationItem quantity="1" lineNumber="2"><UnitOfMeasure>EA</UnitOfMeasure><ConfirmationStatus quantity="1" type="reject"><UnitOfMeasure>EA</UnitOfMeasure><Comments type="LineItemErrorCode_222">The item was successfully processed in Test mode. However, the order was not shipped and you were not charged, since it was placed in Test mode.</Comments></ConfirmationStatus></ConfirmationItem></ConfirmationRequest></Request></cXML>';
            
            Dom.Document doc = new Dom.Document();
            doc.load(response);
            //Retrieve the root element for this document.
            dom.XmlNode root = doc.getRootElement();
            system.debug('RequestItem--->'+root);
            string Orderid = root.getChildElement('Request',null).getChildElement('ConfirmationRequest',null).getChildElement('OrderReference',null).getAttributeValue('orderID',Null);
            ocd.OrderId = Orderid;
            system.debug('Orderid--->'+Orderid);//DocumentReference
            //string payloadId = root.getChildElement('Request',null).getChildElement('ConfirmationRequest',null).getChildElement('OrderReference',null).getChildElement('DocumentReference',null).getAttributeValue('payloadID',Null);
            //system.debug('payloadId--->'+payloadId);
           /* dom.XmlNode [] ConfirmationRequestLst = root.getChildElement('Request',null).getChildElement('ConfirmationRequest',null).getChildElements() ;
            System.debug('ConfirmationitemsLst-->'+ConfirmationRequestLst.size());
            list<ConfirmationItem> ciList = new list<ConfirmationItem>();
            for(dom.XmlNode cr : ConfirmationRequestLst)
            {
                if(cr.getName().equalsIgnoreCase('confirmationitem'))
                {
                    ConfirmationItem ciw = new ConfirmationItem();
                    //system.debug('LineNumber--->'+cr.getAttribute('lineNumber',Null));
                    //system.debug('--->'+cr.getChildElement('ConfirmationStatus',Null).getChildElement('Comments',Null).getText());
                    string uom = cr.getChildElement('ConfirmationStatus',Null).getChildElement('UnitOfMeasure',Null).getText();
                    ciw.UnitOfMeasure = uom!=null?uom:'';
                    /*string qnty =  cr.getAttribute('quantity',Null);
                    ciw.quantity = qnty!=null?qnty:'0';
                    string ln = cr.getAttribute('lineNumber',Null);
                    ciw.lineNumber = ln!=Null?ln:'';
                    string TA = cr.getChildElement('ConfirmationStatus',Null).getChildElement('Tax',Null).getChildElement('Money',Null).getText();
                    ciw.TaxAmount = TA!=Null?TA:'0';
                    string TD = cr.getChildElement('ConfirmationStatus',Null).getChildElement('Tax',Null).getChildElement('Description',Null).getText();
                    ciw.TaxDiscription = TD!=Null?TD:'';
                    string SA = cr.getChildElement('ConfirmationStatus',Null).getChildElement('Shipping',Null).getChildElement('Money',Null).getText();
                    ciw.ShippingAmount = SA!=Null?SA:'0';
                    string SD = cr.getChildElement('ConfirmationStatus',Null).getChildElement('Shipping',Null).getChildElement('Description',Null).getText();
                    ciw.ShippingDescription = SD!=Null?SD:'';*/
                    /*string cmnts = cr.getChildElement('ConfirmationStatus',Null).getChildElement('Comments',Null).getText();
                    ciw.comments = cmnts!= Null ? cmnts : '';
                    ciList.add(ciw);
                }
            }
            
            system.debug('ciList--->'+ciList);
            ocd.confrimationItemsList = ciList;*/
            system.debug('ocd--->'+ocd);
            
            if(ocd.OrderID!=Null)
            {
                Opportunity opty = [select id,Order_id__c,stagename from opportunity where Order_id__c =: ocd.OrderID limit 1];
                opty.StageName = 'Confirmed';
                update opty;
                string resstr = GenerateXMLResponse.successXMLgen();
                Return resstr;
            }
            
            
            /*if(!scd.confrimationItemsList.isEmpty())
            {
                
                //Opportunity opp = new Opportunity(name ='AmozonOpty',stagename='Proposal',CloseDate=system.today().addDays(6),Description = 'Order updated sucessfully',
                //                                LeadSource='Web'); 
                //Insert opp;
                string resstr = GenerateXMLResponse.successXMLgen();
                Return resstr;
            }*/
            
            
            else
            {
                string resstr = GenerateXMLResponse.failureXMLgen();
                Return resstr;
            }
            string resstr = GenerateXMLResponse.failureXMLgen();
            Return resstr;
        }
        catch(Exception ex)
        {
            System.debug('ErrorLineNumber--->'+ex.getStackTraceString());
            system.debug('getMessage--->'+ex.getMessage());
            string resstr = GenerateXMLResponse.failureXMLgen();
            Return resstr;
        }
        
    }
    
    
    Public class OrderConfirmDetails
    {
        Public string OrderID;
        Public string operation;
        Public string OrderTotal;
        public string TaxAmount;
        Public string TaxDiscription;
        Public string ShippingAmount;
        Public string ShippingDescription;
        public list<ConfirmationItem> confrimationItemsList ;
    }
    public class ConfirmationItem
    {
        public string UnitOfMeasure;
        public string lineNumber;
        public string quantity;
        public string TaxAmount;
        Public string TaxDiscription;
        Public string ShippingAmount;
        Public string ShippingDescription;
        Public string comments;
        
    }
}