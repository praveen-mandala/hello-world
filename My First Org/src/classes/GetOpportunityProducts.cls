/*
* @Author               : Praveen M
* @Description          : Client to invoke Ordering API
* @Date Of Creation     : 31-Oct-17
* @Modified by          : 
* @Modified Date        : 
* @Modifiction History  :
*/
global class GetOpportunityProducts implements Database.AllowsCallouts{

    /*
* @Author               : Praveen M
* @Description          : Client to invoke Amazon Ordering API
* @Date Of Creation     : 31-Oct-17
* @Modified by          : Gopinadh Sonti
* @Modified Date        : 10-Nov-17
* @Modifiction History  : Added limits to the query to avoid hitting 
*/
    public static void getProductsAndRole(List<String> oppLst){
        List<Opportunity> oppList = [Select Name,Order_ID__c, (Select Id,Name,ProductCode,Product2.Offer_Id__c,Quantity,unitPrice From OpportunityLineItems limit 150),
                                     (Select Contact.Name,role,ContactId,Contact.MailingStreet,Contact.MailingCity,
                                      Contact.MailingState,Contact.MailingPostalCode,Contact.MailingCountry,
                                      Contact.Phone,Contact.Email
                                      From OpportunityContactRoles limit 1
                                      //Where role='Shipping User'
                                     )
                                     From Opportunity Where ID IN :oppLst];
        
        List<OrderDetails> orderLst = new List<OrderDetails>();
        for(Opportunity oppRec : oppList) {
            OpportunityContactRole shipCon = new OpportunityContactRole();
            OrderDetails order = new OrderDetails();
            order.oppId = oppRec.Id;
            order.OrderID = oppRec.Order_ID__c!=Null?oppRec.Order_ID__c:'';
                
            List<productDetails> prodLst = new List<productDetails>();
            List<OpportunityLineItem> oppProductLst = oppRec.OpportunityLineItems;
            if (oppRec.OpportunityContactRoles!=Null&&oppRec.OpportunityContactRoles.size()>0)
            {
                shipCon=oppRec.OpportunityContactRoles[0];
            }
            //OpportunityContactRole shipCon = oppRec.OpportunityContactRoles[0];
            for(OpportunityLineItem oppLI : oppProductLst) {
                productDetails prodObj = new productDetails();
                prodObj.productCode = oppLI.ProductCode;
                prodObj.offerId = oppLI.Product2.Offer_Id__c;
                prodObj.quantity = Integer.valueOf(oppLI.Quantity!=Null?oppLI.Quantity:0);
                prodObj.prdUnitPrice=oppLI.unitPrice;
                prodLst.add(prodObj);
            }
            order.prodDetailLst = prodLst;
            
            AddressDetails conAddr = new AddressDetails();
            conAddr.name = shipCon.Contact.Name;
            conAddr.street = shipCon.Contact.MailingStreet;
            conAddr.state = shipCon.Contact.MailingState;
            conAddr.city = shipCon.Contact.MailingCity;
            conAddr.postalCode = shipCon.Contact.MailingPostalCode;
            conAddr.country = shipCon.Contact.MailingCountry;
            conAddr.phone = shipCon.Contact.Phone;
            conAddr.email = shipCon.Contact.Email;
            order.address = conAddr;
            
            orderLst.add(order);
            
        }
        System.debug('orderLst-->'+orderLst);
        String finalXml = PrepareOrdersXmlBody.sendRequest(orderLst);
        system.debug('finalXml--->'+finalXml);
        System.debug('check');
        callOrderAPI(finalXml , oppLst);
    }
    
    /*
* @Author               : Praveen M
* @Description          : Client to invoke AWS
* @Date Of Creation     : 31-Oct-17
* @Modified by          : 
* @Modified Date        : 
* @Modifiction History  :
*/
    @future(callout=true)
    public static void callOrderAPI(String xmlBody , List<String> oppLst) {
        System.debug('Test');
		String endpoint = 'https://https.amazonsedi.com/eeccb213-452e-44a6-b89d-ddf1a50d8ebb';
        HttpRequest res = new HttpRequest();
        res.setMethod('POST');
        res.setEndpoint(endpoint);
        res.setBody(xmlBody);
        Http http = new Http();
        HTTPResponse resp = http.send(res);
        String response = resp.getBody();
        system.debug('response---->'+response);
        if(response.contains('200')) {
            List<Opportunity> oppRecLst = [Select Id,Description from Opportunity where ID IN :oppLst];
            system.debug('oppRecLst--->'+oppRecLst);
                for(Opportunity oppObj : oppRecLst) {
                    oppObj.Description = 'The order is placed on '+string.valueof(system.now().date()).substringBefore(' ') + ' at ' +system.now().time();
                }
            update oppRecLst;
        }
    }
    
    
    public class productDetails {
        public String productCode;
        public String offerId;
        public Integer quantity;
        public decimal prdUnitPrice;
    }
    public class AddressDetails {
        public String name;
        public String phone;
        public String email;
		public String street;
        public String city;
        public String state;
        public String country;
        public String postalCode;
    }
    public class OrderDetails {
        public String oppId;
        public string OrderID;
        public List<productDetails> prodDetailLst;
        public AddressDetails address;
    }
}