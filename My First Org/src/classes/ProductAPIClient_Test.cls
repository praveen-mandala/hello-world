/*
* @Author               : Gopinadh Sonti
* @Description          : Test class for ProductAPIClient
* @Date Of Creation     : 3-Nov-17
* @Modified by          : 
* @Modified Date        : 
* @Modifiction History  :
*/
@isTest
public class ProductAPIClient_Test {
    
    static testmethod void testProductAPIClient()
    {
        ProductAPIDetails__c pad = new ProductAPIDetails__c(name='Test',endpointURL__c='http://webservices.amazon.com/onca/xml?',AssociateTag__c='supplytheteac-20',AWSAccessKeyId__c='AKIAJAPPFUTSV544LJZA',secret_Key__c='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');
        insert pad;
        /*
        list<product2> pdlist = new list<product2>();
        list<string> pcstrlist = new list<string>(); 
        string pcstr = '';
        for (integer i=0;i<=10;i++)
        {
            integer pc = 1598572727;
            pcstr += pc +',';
            pcstrlist.add(string.valueof(pc));
        	Product2 pd = new Product2(Name='TestProduct'+i,ProductCode=string.valueOf(pc+i),IsActive=true,Last_Synced_On__c=system.date.today().adddays(-i),Offer_Id__c='offer50'+i);
            pdlist.add(pd);
        }
        Product2 pd = new Product2(Name='TestProductNooffer',ProductCode='1592152727',IsActive=true,Last_Synced_On__c=system.date.today().adddays(-4),Offer_Id__c='');
        pdlist.add(pd);
        INSERT pdlist;
        */
        string prductcodes = '1423472683,1452275718,1938166000,1598572709,007802708X,0135039444,1420082175,1305959884,1259657574,1118771338';
        Test.startTest();
            ProductAPIClient pac = new ProductAPIClient();
            Test.setMock(HttpCalloutMock.class, new ProductAPIMock());
            pac.getOfferDetails(prductcodes);
        Test.stopTest();
        //pac.domParsingResponseXml();
        //ProductAPIClient.finalOfferDetails pacfod = new ProductAPIClient.finalOfferDetails();
        //ProductAPIClient.getOfferDetails(pcstr);
        //pacfod ProductAPIClient.domParsingResponseXml();
    }
}