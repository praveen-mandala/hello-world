public class ShippingXmlParser {
    
    public static void xmlParser()
    {
        try
        {
            String xmlString = '<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE cXML SYSTEM "http://xml.cxml.org/schemas/cXML/1.2.024/Fulfill.dtd"> <cXML payloadID="1394645847931.18059.42xx@amazon.com" timestamp="2014-03-12T17:37:27+17:37" xml:lang="en-US">  <Header>    <From>      <Credential domain="NetworkId">        <Identity>010117xxxxx</Identity>      </Credential>    </From>    <To>      <Credential domain="NetworkId">        <Identity>010011xxxxx</Identity>      </Credential>    </To>    <Sender>      <Credential domain="NetworkId">        <Identity>010118xxxxx</Identity>      </Credential>      <UserAgent>Amazon LLC eProcurement Application</UserAgent>    </Sender>  </Header>  <Request>    <ShipNoticeRequest>      <ShipNoticeHeader shipmentID="2199947375124" operation=      "new" noticeDate="2014-03-12T17:37:35+17:37" shipmentDate=       "2014-03-12T17:32:02+17:32"        deliveryDate="2014-03-14T03:00:00+03:00"        shipmentType="actual"/>      <ShipControl>       <CarrierIdentifier domain="companyName"></CarrierIdentifier>        <ShipmentIdentifier>1Z1Y2E270339295041</ShipmentIdentifier>        <PackageIdentification rangeBegin="1" rangeEnd="1"/>      </ShipControl>      <ShipNoticePortion>        <OrderReference orderDate="2014-03-11T15:57:28-04:00"         orderID="E010653511xxxx">          <DocumentReference     payloadID="1394567848065.10310490xx.OrderRequest@xx.org"/>        </OrderReference> <ShipNoticeItem lineNumber="10" quantity="2">          <UnitOfMeasure>EA</UnitOfMeasure>        </ShipNoticeItem>        <ShipNoticeItem lineNumber="4" quantity="2">          <UnitOfMeasure>EA</UnitOfMeasure>        </ShipNoticeItem>        <ShipNoticeItem lineNumber="13" quantity="2">          <UnitOfMeasure>EA</UnitOfMeasure>        </ShipNoticeItem>        <ShipNoticeItem lineNumber="6" quantity="2">          <UnitOfMeasure>EA</UnitOfMeasure>        </ShipNoticeItem>        <ShipNoticeItem lineNumber="5" quantity="2">          <UnitOfMeasure>EA</UnitOfMeasure>        </ShipNoticeItem>        <ShipNoticeItem lineNumber="7" quantity="2">          <UnitOfMeasure>EA</UnitOfMeasure>        </ShipNoticeItem>        <ShipNoticeItem lineNumber="2" quantity="2">          <UnitOfMeasure>EA</UnitOfMeasure>        </ShipNoticeItem>        <ShipNoticeItem lineNumber="9" quantity="2">          <UnitOfMeasure>EA</UnitOfMeasure>        </ShipNoticeItem>        <ShipNoticeItem lineNumber="12" quantity="2">          <UnitOfMeasure>EA</UnitOfMeasure>        </ShipNoticeItem>        <ShipNoticeItem lineNumber="8" quantity="2">          <UnitOfMeasure>EA</UnitOfMeasure>        </ShipNoticeItem>        <ShipNoticeItem lineNumber="14" quantity="2">          <UnitOfMeasure>EA</UnitOfMeasure>        </ShipNoticeItem>        <ShipNoticeItem lineNumber="11" quantity="2">          <UnitOfMeasure>EA</UnitOfMeasure>        </ShipNoticeItem>        <ShipNoticeItem lineNumber="15" quantity="2">          <UnitOfMeasure>EA</UnitOfMeasure>        </ShipNoticeItem>        <ShipNoticeItem lineNumber="3" quantity="2">          <UnitOfMeasure>EA</UnitOfMeasure>        </ShipNoticeItem>        <ShipNoticeItem lineNumber="1" quantity="2">          <UnitOfMeasure>EA</UnitOfMeasure>        </ShipNoticeItem>      </ShipNoticePortion>    </ShipNoticeRequest> </Request></cXML>';
            Dom.Document doc = new Dom.Document();
            //finalWrapper wprObj;
            doc.load(xmlString);
            //Retrieve the root element for this document.
            Dom.XMLNode cXML = doc.getRootElement();
            shippingDetails sd = new shippingDetails();
            System.debug('cXML-->'+cXML);
            /*for(dom.XmlNode child : cXML.getChildElement('Header',Null).getchildelements())
            {
                //System.debug('Child Name-->'+child.getChildElement('Credential',Null).getChildElement('Identity',Null).getText());    
            }
            */
            for(dom.XmlNode child : cXML.getChildElement('Request',Null).getchildelements())
            {
                system.debug('shipmentID--->'+child.getChildElement('ShipNoticeHeader',Null).getAttributeValue('shipmentID',Null));
                system.debug('shipmentDate--->'+child.getChildElement('ShipNoticeHeader',Null).getAttributeValue('shipmentDate',Null));
                system.debug('deliveryDate--->'+child.getChildElement('ShipNoticeHeader',Null).getAttributeValue('deliveryDate',Null));
                string shpmtId = child.getChildElement('ShipNoticeHeader',Null).getAttributeValue('shipmentID',Null);
                sd.shipmentID = shpmtId!=Null?shpmtId:'';
                string shpmtDt = child.getChildElement('ShipNoticeHeader',Null).getAttributeValue('shipmentDate',Null);
                sd.shipmentDate = shpmtDt!=Null?shpmtDt:'';
                string shpmtDelDt = child.getChildElement('ShipNoticeHeader',Null).getAttributeValue('deliveryDate',Null);
                sd.deliveryDate = shpmtDelDt!=Null?shpmtDelDt:'';
                system.debug('Name--->'+child.getChildElement('ShipNoticePortion',Null).getName());
                list<ShipNoticeItem> sniList = new list<ShipNoticeItem>();
                //dom.XmlNode [] ShipNItems = child.getChildElement('ShipNoticePortion',Null).getChildElements();
                //system.debug('===>'+ShipNItems.size());
                for(dom.XmlNode ch: child.getChildElement('ShipNoticePortion',Null).getChildElements())
                {
                    if(ch.getname()=='ShipNoticeItem')
                    {
                        ShipNoticeItem si = new ShipNoticeItem();
                        string ln = ch.getAttributeValue('lineNumber',Null);
                        si.LineNumber = ln!=Null?ln:'';
                        string qnty = ch.getAttributeValue('quantity',Null);
                        si.qunatity = qnty!=Null?qnty:'0';
                        string uom = ch.getChildElement('UnitOfMeasure',Null).getText();
                        si.UnitOfMeasure = uom!=Null?uom:'';
                        sniList.add(si);
                    }
                    //System.debug('linenumber-->'+ch.getAttributeValue('lineNumber',Null));    
                }
                system.debug('sniListSize---->'+sniList.size());
                sd.ShipNoticeItems = sniList;
            }
            system.debug('sd--->'+sd);
        }
        catch(exception ex)
        {
            System.debug('ErrorLineNumber--->'+ex.getStackTraceString());
            system.debug('getMessage--->'+ex.getMessage());
        }
        
        
    }
    public class shippingDetails
    {
        public string shipmentID;
        public string shipmentDate;
        public string deliveryDate;
        public string shipmentType;
        public list<ShipNoticeItem> ShipNoticeItems;
    }
    Public class ShipNoticeItem
    {
        public string qunatity;
        public string LineNumber;
        public string UnitOfMeasure;
    }
}