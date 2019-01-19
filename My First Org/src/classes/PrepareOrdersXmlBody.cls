/*
* @Author               : Praveen M
* @Description          : Client to invoke Ordering API
* @Date Of Creation     : 31-Oct-17
* @Modified by          : Gopinadh Sonti
* @Modified Date        : 10-Nov-17
* @Modifiction History  :Added OrderID (Opty Field) Attribute to OrderRequestHeader
*/
public class PrepareOrdersXmlBody
{
    public static String sendRequest(List<GetOpportunityProducts.OrderDetails> orderLst)//
    {
        // Create the request envelope
        DOM.Document doc = new DOM.Document();
        
        //Datetime myDT = System.now();
        String now = System.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSS');
        
        //String now = String.ValueOf(System.now());
        String xml = 'http://www.w3.org/XML/1998/namespace';
        dom.XmlNode cXml = doc.createRootElement('cXML', null, null);
        cXml.setNamespace('xml', xml);
        cXml.setAttributeNS('version', '1.2.017', null , null);
        cXml.setAttributeNS('lang','en-US',xml,null);
        string payload = '20151206ABCDE.'+String.valueOf(Math.abs(Crypto.getRandomInteger()))+'.3418072@amazon12345.com';
        cXml.setAttributeNS('payloadID',payload,null ,null);
        cXml.setAttributeNS('timestamp',now,null ,null);
        
        
        dom.XmlNode Header = cXml.addChildElement('Header', null, null);
        dom.XmlNode fromCredential = Header.addChildElement('From', null, null).addChildElement('Credential', null, null);
        fromCredential.setAttributeNS('domain', 'NetworkId', null , null);
        fromCredential.addChildElement('Identity', null, null).addTextNode('SupplyTheTeachers7886716302');
        
        dom.XmlNode toCredential = Header.addChildElement('To', null, null).addChildElement('Credential', null, null);
        toCredential.setAttributeNS('domain', 'NetworkId', null , null);
        toCredential.addChildElement('Identity', null, null).addTextNode('Amazon');
        
        dom.XmlNode senderCredential = Header.addChildElement('Sender', null, null).addChildElement('Credential', null, null);
        senderCredential.setAttributeNS('domain', 'NetworkId', null , null);
        
        senderCredential.addChildElement('Identity', null, null).addTextNode('SupplyTheTeachers7886716302');
        senderCredential.addChildElement('SharedSecret', null, null).addTextNode('Ubu30x2CpxgKF5tIVURLk6OxX0Pph3');
        
        dom.XmlNode Request = cXml.addChildElement('Request', null, null);
        Request.setAttributeNS('deploymentMode','production',null,null);
        
        for(GetOpportunityProducts.OrderDetails order : orderLst) {
            
            dom.XmlNode OrderRequest = Request.addChildElement('OrderRequest', null, null);
            dom.XmlNode OrderRequestHeader = OrderRequest.addChildElement('OrderRequestHeader', null, null);
            
            OrderRequestHeader.setAttributeNS('orderDate', now , null , null);
            OrderRequestHeader.setAttributeNS('orderID', order.OrderID!=null?order.OrderID:'' , null , null);//Newly added based on client requirement on 10th Nov
            OrderRequestHeader.setAttributeNS('orderType', 'regular' , null , null);
            OrderRequestHeader.setAttributeNS('orderVersion', '1' , null , null);
            OrderRequestHeader.setAttributeNS('type', 'new' , null , null);
            
            GetOpportunityProducts.AddressDetails conAddr = order.address;
            System.debug('conAddr-->'+conAddr);
            dom.XmlNode ShipTo = OrderRequestHeader.addChildElement('ShipTo', null, null);
            dom.XmlNode Address = ShipTo.addChildElement('Address', null, null);
            Address.setAttributeNS('isoCountryCode', 'US' , null , null);
            dom.XmlNode Name = Address.addChildElement('Name', null, null);
            Name.setAttributeNS('lang','en-US',xml,null);
            Name.addTextNode('Main Address');
            dom.XmlNode PostalAddress = Address.addChildElement('PostalAddress', null, null);
            PostalAddress.setAttributeNS('name','default',null,null);
            PostalAddress.addChildElement('DeliverTo', null, null).addTextNode(conAddr.name!=null?conAddr.name:'');
            system.debug('conAddr.street---->'+conAddr.street);
            PostalAddress.addChildElement('Street', null, null).addTextNode(conAddr.street!=null?conAddr.street:'');
            PostalAddress.addChildElement('City', null, null).addTextNode(conAddr.city!=null?conAddr.city:'');
            PostalAddress.addChildElement('State', null, null).addTextNode(conAddr.state!=null?conAddr.state:'');
            PostalAddress.addChildElement('PostalCode', null, null).addTextNode(conAddr.postalCode!=null?conAddr.postalCode:'');
            
            
            dom.XmlNode country = PostalAddress.addChildElement('Country', null, null);
            country.addTextNode(conAddr.country!=null?conAddr.country:'');//!=null?:''
            country.setAttributeNS('isoCountryCode','US',null,null);
            
            dom.XmlNode Email = Address.addChildElement('Email', null, null);
            Email.setAttributeNS('name','default',null,null);
            Email.addTextNode(conAddr.email!=null?conAddr.email:'');
            
            dom.XmlNode Phone = Address.addChildElement('Phone', null, null);
            Phone.setAttributeNS('name','default',null,null);
            
            dom.XmlNode TelephoneNumber =  Phone.addChildElement('TelephoneNumber', null, null);
               
            //TelephoneNumber.setAttributeNS('isoCountryCode','US',null,null);
           // TelephoneNumber.addTextNode('1');
            dom.XmlNode CountryCode = TelephoneNumber.addChildElement('CountryCode', null, null);
            CountryCode.setAttributeNS('isoCountryCode','US',null,null);
            CountryCode.addTextNode('111');
            TelephoneNumber.addChildElement('AreaOrCityCode', null, null).addTextNode('111');
            TelephoneNumber.addChildElement('Number', null, null).addTextNode(conAddr.phone!=null?conAddr.phone:'');
           
            dom.XmlNode ExtrinsicEmail = OrderRequestHeader.addChildElement('Extrinsic', null, null);
            ExtrinsicEmail.setAttributeNS('name','email',null,null);
            ExtrinsicEmail.addTextNode(conAddr.email!=null?conAddr.email:'');
            
            List<GetOpportunityProducts.productDetails> prodLst = order.prodDetailLst;
            Integer line = 1;
            for(GetOpportunityProducts.productDetails prodObj: prodLst) {
                dom.XmlNode ItemOut = OrderRequest.addChildElement('ItemOut', null, null);
                ItemOut.setAttributeNS('quantity',String.valueOf(prodObj.quantity),null,null);
                ItemOut.setAttributeNS('lineNumber',String.valueOf(line),null,null);
                
                dom.XmlNode ItemID = ItemOut.addChildElement('ItemID', null, null);
                ItemID.addChildElement('SupplierPartID', null, null).addTextNode(prodObj.productCode!=Null?prodObj.productCode:'');
                
                dom.XmlNode ItemDetail = ItemOut.addChildElement('ItemDetail', null, null);
                dom.XmlNode UnitPrice = ItemDetail.addChildElement('UnitPrice', null, null);
                dom.XmlNode Money= UnitPrice.addChildElement('Money', null, null);
                Money.setAttributeNS('currency','USD',null,null);
                Money.addTextNode(String.valueOf(prodObj.prdUnitPrice)!=Null?String.valueOf(prodObj.prdUnitPrice):'');
                 dom.XmlNode UnitOfMeasure = ItemDetail.addChildElement('UnitOfMeasure', null, null).addTextNode('EA');
                
                dom.XmlNode ExtrinsicOffer = ItemID.addChildElement('Extrinsic', null, null);
                ExtrinsicOffer.setAttributeNS('name','OfferId',null,null);
                ExtrinsicOffer.addTextNode(prodObj.offerId!=Null?prodObj.offerId:'');
                line++;
            }
            
        }
        System.debug('doc.toXmlString()--->'+doc.toXmlString());
        
        return doc.toXmlString();
        // Send the request
        
    }
}