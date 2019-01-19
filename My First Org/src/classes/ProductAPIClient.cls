/*
* @Author               : Praveen M
* @Description          : Client to invoke AWS
* @Date Of Creation     : 24-Oct-17
* @Modified by          : 
* @Modified Date        : 
* @Modifiction History  :
*/
public class ProductAPIClient {
    /*
* @Author               : Praveen M
* @Description          : Prepares the endpoint url and hits the server
* @Date Of Creation     : 24-Oct-17
* @Modified by          : 
* @Modified Date        : 
* @Modifiction History  :
* @Returns				: 
*/
    
    public finalOfferDetails getOfferDetails(String productCodes) {
        
        ProductAPIDetails__c pad = [SELECT id,endpointURL__c,AssociateTag__c,AWSAccessKeyId__c,secret_Key__c FROM ProductAPIDetails__c WHERE name ='Test' LIMIT 1];
		String secretKey = pad.secret_Key__c!=Null?pad.secret_Key__c:'JKtdOM52BzWd2Vo7Flt3jAV3IgJZ2jw9aoeP1+rc';
		String AWSAccessKeyId = pad.AWSAccessKeyId__c!=Null?pad.AWSAccessKeyId__c:'AKIAJAPPFUTSV544LJZA';
		String AssociateTag = pad.AssociateTag__c!=Null?pad.AssociateTag__c:'supplytheteac-20';
		string endpointURL = pad.endpointURL__c!=Null?pad.endpointURL__c:'http://webservices.amazon.com/onca/xml?';
        /*
        string endpointURL = 'http://webservices.amazon.com/onca/xml?';
        String secretKey = 'JKtdOM52BzWd2Vo7Flt3jAV3IgJZ2jw9aoeP1+rc';
        String AWSAccessKeyId = 'AKIAJAPPFUTSV544LJZA';
        String AssociateTag='supplytheteac-20';
		*/
        String Condition = 'New	';
        String IdType = 'ASIN';
        String ItemId = productCodes;
        String MerchantId= 'Amazon';
        //String OfferPage = '3';
        String Operation = 'ItemLookup';
        String ResponseGroup = 'OfferFull,Offers';
        String Service = 'AWSECommerceService';
        String Timestamp = datetime.now().formatGMT('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'');
        String Version='2013-04-01';
        
        //Forming the requestSignature String inorder to generate Signature
        string requestSignature = 'AWSAccessKeyId='+EncodingUtil.urlEncode(AWSAccessKeyId, 'UTF-8');
        requestSignature +='&AssociateTag='+EncodingUtil.urlEncode(AssociateTag, 'UTF-8');
        requestSignature +='&Condition='+EncodingUtil.urlEncode(Condition, 'UTF-8');
        requestSignature +='&IdType='+EncodingUtil.urlEncode(IdType, 'UTF-8');
        requestSignature +='&ItemId='+EncodingUtil.urlEncode(ItemId, 'UTF-8');
        requestSignature +='&MerchantId='+EncodingUtil.urlEncode(MerchantId, 'UTF-8');
        //requestSignature +='&OfferPage='+EncodingUtil.urlEncode(OfferPage, 'UTF-8');
        requestSignature +='&Operation='+EncodingUtil.urlEncode(Operation, 'UTF-8');
        requestSignature +='&ResponseGroup='+EncodingUtil.urlEncode(ResponseGroup, 'UTF-8');
        requestSignature +='&Service='+EncodingUtil.urlEncode(Service, 'UTF-8');
        requestSignature +='&Timestamp='+EncodingUtil.urlEncode(Timestamp, 'UTF-8');
        requestSignature +='&Version='+EncodingUtil.urlEncode(Version, 'UTF-8');
        //Calling the generateAWSSignature with required parameters to receive Signature for authentication
        String Signature = generateAWSSignature('GET',requestSignature,secretKey);
        //Appending the Signature to create the final endpoint URL.
        endpointURL = endpointURL + requestSignature + '&Signature='+EncodingUtil.urlEncode(Signature, 'UTF-8');
        HttpRequest res = new HttpRequest();
        res.setHeader('UserAgent', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36');
        res.setMethod('GET');
        res.setEndpoint(endpointURL);
        Http http = new Http();
        HTTPResponse resp = http.send(res);
        //Sending the response to parsing engine
        return domParsingResponseXml(resp);
    }
    
    /*
* @Author               : Praveen M
* @Description          : Generates the signature using the secret token and AWS ID.
* @Date Of Creation     : 24-Oct-17
* @Modified by          : 
* @Modified Date        : 
* @Modifiction History  :
* @Returns				: 
*/
    public static string generateAWSSignature(string verb,String request, String SecretKey){
        // Generation of String to Sign	  
        String canonicalRequest = verb+'\n';
        canonicalRequest += 'webservices.amazon.com'+'\n';
        canonicalRequest += '/onca/xml' + '\n';
        canonicalRequest += request;
        // Generating signature with  HmacSHA256 algorithm.
        string key = SecretKey;
        Blob bsig = Crypto.generateMac('HmacSHA256', Blob.valueOf(canonicalRequest), Blob.valueOf(key));
        String signature = EncodingUtil.base64Encode(bsig);
        return signature;
    }
    
    /*
* @Author               : Praveen M
* @Description          : Generates the signature using the secret token and AWS ID.
* @Date Of Creation     : 25-Oct-17
* @Modified by          : 
* @Modified Date        : 
* @Modifiction History  :
* @Returns				: 
*/
    public static finalOfferDetails domParsingResponseXml(HTTPResponse resp1) {
        
        List<finalWrapper> finalWprLst = new List<finalWrapper>();
        String response = resp1.getBody();
       // SendEmailMessage sem = SendEmailMessage();
        //SendEmailMessage.SendEmail(response);
        //String response = '<?xml version="1.0" ?><ItemLookupResponse xmlns="http://webservices.amazon.com/AWSECommerceService/2011-08-01"><OperationRequest><HTTPHeaders><Header Name="UserAgent" Value="SFDC-Callout/41.0"></Header></HTTPHeaders><RequestId>af5b827d-b3cf-42e9-8bca-dc5868c2ae6b</RequestId><Arguments><Argument Name="AWSAccessKeyId" Value="AKIAJAPPFUTSV544LJZA"></Argument><Argument Name="AssociateTag" Value="supplytheteac-20"></Argument><Argument Name="Condition" Value="New	"></Argument><Argument Name="IdType" Value="ASIN"></Argument><Argument Name="ItemId" Value="1423472683,1452275718,1938166000,1598572709,007802708X,0135039444,1420082175,1305959884,1259657574,1118771338"></Argument><Argument Name="MerchantId" Value="All"></Argument><Argument Name="Operation" Value="ItemLookup"></Argument><Argument Name="ResponseGroup" Value="OfferFull"></Argument><Argument Name="Service" Value="AWSECommerceService"></Argument><Argument Name="Timestamp" Value="2017-10-26T06:42:28.639Z"></Argument><Argument Name="Signature" Value="9klS+HGCfKPTwbgP3LkQOqlMnDdfFssCqZag4eg9EYg="></Argument></Arguments><RequestProcessingTime>0.0879479720000000</RequestProcessingTime></OperationRequest><Items><Request><IsValid>True</IsValid><ItemLookupRequest><Condition>New	</Condition><IdType>ASIN</IdType><MerchantId>Deprecated</MerchantId><ItemId>1423472683</ItemId><ItemId>1452275718</ItemId><ItemId>1938166000</ItemId><ItemId>1598572709</ItemId><ItemId>007802708X</ItemId><ItemId>0135039444</ItemId><ItemId>1420082175</ItemId><ItemId>1305959884</ItemId><ItemId>1259657574</ItemId><ItemId>1118771338</ItemId><ResponseGroup>OfferFull</ResponseGroup><VariationPage>All</VariationPage></ItemLookupRequest></Request><Item><ASIN>1423472683</ASIN><OfferSummary><LowestNewPrice><Amount>4321</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$43.21</FormattedPrice></LowestNewPrice><LowestUsedPrice><Amount>4000</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$40.00</FormattedPrice></LowestUsedPrice><TotalNew>28</TotalNew><TotalUsed>14</TotalUsed><TotalCollectible>0</TotalCollectible><TotalRefurbished>0</TotalRefurbished></OfferSummary><Offers><TotalOffers>1</TotalOffers><TotalOfferPages>1</TotalOfferPages><MoreOffersUrl>https://www.amazon.com/gp/offer-listing/1423472683?SubscriptionId=AKIAJAPPFUTSV544LJZA&amp;tag=supplytheteac-20&amp;linkCode=xm2&amp;camp=2025&amp;creative=386001&amp;creativeASIN=1423472683</MoreOffersUrl><Offer><Merchant><Name>Amazon.com</Name></Merchant><OfferAttributes><Condition>New</Condition></OfferAttributes><OfferListing><OfferListingId>ZIG%2F06ZQGsBle5gpMc2db5pNsrSVlF84EawzHSSQXJHdrwBHPMBmXwd2fnj7tEttKF1IruaM95D7f9e1Tkcwl2EgDnvsElndH%2BbKPtiKjHNjPQIhvBb8PA%3D%3D</OfferListingId><Price><Amount>5298</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$52.98</FormattedPrice></Price><AmountSaved><Amount>1702</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$17.02</FormattedPrice></AmountSaved><PercentageSaved>24</PercentageSaved><Availability>Usually ships in 24 hours</Availability><AvailabilityAttributes><AvailabilityType>now</AvailabilityType><MinimumHours>0</MinimumHours><MaximumHours>0</MaximumHours></AvailabilityAttributes><IsEligibleForSuperSaverShipping>1</IsEligibleForSuperSaverShipping><IsEligibleForPrime>1</IsEligibleForPrime></OfferListing></Offer></Offers></Item><Item><ASIN>1452275718</ASIN><OfferSummary><LowestNewPrice><Amount>7555</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$75.55</FormattedPrice></LowestNewPrice><LowestUsedPrice><Amount>4763</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$47.63</FormattedPrice></LowestUsedPrice><TotalNew>11</TotalNew><TotalUsed>15</TotalUsed><TotalCollectible>0</TotalCollectible><TotalRefurbished>0</TotalRefurbished></OfferSummary><Offers><TotalOffers>1</TotalOffers><TotalOfferPages>1</TotalOfferPages><MoreOffersUrl>https://www.amazon.com/gp/offer-listing/1452275718?SubscriptionId=AKIAJAPPFUTSV544LJZA&amp;tag=supplytheteac-20&amp;linkCode=xm2&amp;camp=2025&amp;creative=386001&amp;creativeASIN=1452275718</MoreOffersUrl><Offer><Merchant><Name>Amazon.com</Name></Merchant><OfferAttributes><Condition>New</Condition></OfferAttributes><OfferListing><OfferListingId>ZIG%2F06ZQGsCitpgcvgBNHXJJl9tUtWDZvqeLExIabiAiqgYeNf5IvSTHhE%2FfINGVV6I7mAEC08i%2F5cBh6At493kKPFDOuxiAuYR9TG9pUDOQeYkS1xN52A%3D%3D</OfferListingId><Price><Amount>8744</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$87.44</FormattedPrice></Price><AmountSaved><Amount>1556</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$15.56</FormattedPrice></AmountSaved><PercentageSaved>15</PercentageSaved><Availability>Usually ships in 24 hours</Availability><AvailabilityAttributes><AvailabilityType>now</AvailabilityType><MinimumHours>0</MinimumHours><MaximumHours>0</MaximumHours></AvailabilityAttributes><IsEligibleForSuperSaverShipping>1</IsEligibleForSuperSaverShipping><IsEligibleForPrime>1</IsEligibleForPrime></OfferListing></Offer></Offers></Item><Item><ASIN>1938166000</ASIN><OfferSummary><LowestUsedPrice><Amount>8100</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$81.00</FormattedPrice></LowestUsedPrice><TotalNew>0</TotalNew><TotalUsed>9</TotalUsed><TotalCollectible>0</TotalCollectible><TotalRefurbished>0</TotalRefurbished></OfferSummary><Offers><TotalOffers>0</TotalOffers><TotalOfferPages>0</TotalOfferPages><MoreOffersUrl>0</MoreOffersUrl></Offers></Item><Item><ASIN>1598572709</ASIN><OfferSummary><LowestNewPrice><Amount>5082</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$50.82</FormattedPrice></LowestNewPrice><LowestUsedPrice><Amount>4567</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$45.67</FormattedPrice></LowestUsedPrice><TotalNew>12</TotalNew><TotalUsed>16</TotalUsed><TotalCollectible>0</TotalCollectible><TotalRefurbished>0</TotalRefurbished></OfferSummary><Offers><TotalOffers>1</TotalOffers><TotalOfferPages>1</TotalOfferPages><MoreOffersUrl>https://www.amazon.com/gp/offer-listing/1598572709?SubscriptionId=AKIAJAPPFUTSV544LJZA&amp;tag=supplytheteac-20&amp;linkCode=xm2&amp;camp=2025&amp;creative=386001&amp;creativeASIN=1598572709</MoreOffersUrl><Offer><Merchant><Name>Amazon.com</Name></Merchant><OfferAttributes><Condition>New</Condition></OfferAttributes><OfferListing><OfferListingId>sgZjUoIS4BRaY3%2FdNy5r%2FdiBWCne6BtpdsSVt1hPOxxQUa9vzGqc5nh2ZYP5EzRoPOHpE3h8m%2FjPxRjxHXEy9kXeGV000lRyZnIhzcf62G7MRwhGoxsFkw%3D%3D</OfferListingId><Price><Amount>5993</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$59.93</FormattedPrice></Price><AmountSaved><Amount>2</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$0.02</FormattedPrice></AmountSaved><Availability>Usually ships in 24 hours</Availability><AvailabilityAttributes><AvailabilityType>now</AvailabilityType><MinimumHours>0</MinimumHours><MaximumHours>0</MaximumHours></AvailabilityAttributes><IsEligibleForSuperSaverShipping>1</IsEligibleForSuperSaverShipping><IsEligibleForPrime>1</IsEligibleForPrime></OfferListing></Offer></Offers></Item><Item><ASIN>007802708X</ASIN><OfferSummary><LowestNewPrice><Amount>4200</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$42.00</FormattedPrice></LowestNewPrice><LowestUsedPrice><Amount>3707</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$37.07</FormattedPrice></LowestUsedPrice><TotalNew>16</TotalNew><TotalUsed>41</TotalUsed><TotalCollectible>0</TotalCollectible><TotalRefurbished>0</TotalRefurbished></OfferSummary><Offers><TotalOffers>1</TotalOffers><TotalOfferPages>1</TotalOfferPages><MoreOffersUrl>https://www.amazon.com/gp/offer-listing/007802708X?SubscriptionId=AKIAJAPPFUTSV544LJZA&amp;tag=supplytheteac-20&amp;linkCode=xm2&amp;camp=2025&amp;creative=386001&amp;creativeASIN=007802708X</MoreOffersUrl><Offer><Merchant><Name>iCText Shop</Name></Merchant><OfferAttributes><Condition>New</Condition></OfferAttributes><OfferListing><OfferListingId>ZIG%2F06ZQGsA8EDtt4knyiaUAy4cKdOMlQE1uAtJi62v3IUud%2FoZPYXBR5uKqKRk2MckQohDhXnFIaHhIC3IXgUG7AaA6WuWt%2F3EHHe%2F2%2FrCriYGN3h6YZry6IXTqZAgdwGQ%2BCOhYM0eivqpXr1KCQsS5d%2FHp%2Fgio</OfferListingId><Price><Amount>16500</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$165.00</FormattedPrice></Price><SalePrice><Amount>8995</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$89.95</FormattedPrice></SalePrice><AmountSaved><Amount>7505</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$75.05</FormattedPrice></AmountSaved><PercentageSaved>45</PercentageSaved><Availability>Usually ships in 24 hours</Availability><AvailabilityAttributes><AvailabilityType>now</AvailabilityType><MinimumHours>0</MinimumHours><MaximumHours>0</MaximumHours></AvailabilityAttributes><IsEligibleForSuperSaverShipping>1</IsEligibleForSuperSaverShipping><IsEligibleForPrime>1</IsEligibleForPrime></OfferListing></Offer></Offers></Item><Item><ASIN>0135039444</ASIN><OfferSummary><LowestNewPrice><Amount>9489</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$94.89</FormattedPrice></LowestNewPrice><LowestUsedPrice><Amount>2271</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$22.71</FormattedPrice></LowestUsedPrice><TotalNew>8</TotalNew><TotalUsed>18</TotalUsed><TotalCollectible>0</TotalCollectible><TotalRefurbished>0</TotalRefurbished></OfferSummary><Offers><TotalOffers>1</TotalOffers><TotalOfferPages>1</TotalOfferPages><MoreOffersUrl>https://www.amazon.com/gp/offer-listing/0135039444?SubscriptionId=AKIAJAPPFUTSV544LJZA&amp;tag=supplytheteac-20&amp;linkCode=xm2&amp;camp=2025&amp;creative=386001&amp;creativeASIN=0135039444</MoreOffersUrl><Offer><Merchant><Name>_nearfine_</Name></Merchant><OfferAttributes><Condition>New</Condition></OfferAttributes><OfferListing><OfferListingId>ZIG%2F06ZQGsBF63kVwDO9cY5SLJqEZo7DENMBa0Ye3Nhz1F3xntCUBVRaIwmDoxpgyjkkkr9e3xLE0XGbSucUpuOrfuLTT10rqoNBcZJw8DsVXeExhWYd1%2BA2rS1A0j5L6NWomQPpx5YWCmFUhyBPog%3D%3D</OfferListingId><Price><Amount>9499</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$94.99</FormattedPrice></Price><AmountSaved><Amount>2781</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$27.81</FormattedPrice></AmountSaved><PercentageSaved>23</PercentageSaved><Availability>Usually ships in 1-2 business days</Availability><AvailabilityAttributes><AvailabilityType>now</AvailabilityType><MinimumHours>24</MinimumHours><MaximumHours>48</MaximumHours></AvailabilityAttributes><IsEligibleForSuperSaverShipping>0</IsEligibleForSuperSaverShipping><IsEligibleForPrime>0</IsEligibleForPrime></OfferListing></Offer></Offers></Item><Item><ASIN>1420082175</ASIN><OfferSummary><LowestNewPrice><Amount>11006</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$110.06</FormattedPrice></LowestNewPrice><LowestUsedPrice><Amount>8499</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$84.99</FormattedPrice></LowestUsedPrice><TotalNew>11</TotalNew><TotalUsed>8</TotalUsed><TotalCollectible>0</TotalCollectible><TotalRefurbished>0</TotalRefurbished></OfferSummary><Offers><TotalOffers>1</TotalOffers><TotalOfferPages>1</TotalOfferPages><MoreOffersUrl>https://www.amazon.com/gp/offer-listing/1420082175?SubscriptionId=AKIAJAPPFUTSV544LJZA&amp;tag=supplytheteac-20&amp;linkCode=xm2&amp;camp=2025&amp;creative=386001&amp;creativeASIN=1420082175</MoreOffersUrl><Offer><Merchant><Name>Amazon.com</Name></Merchant><OfferAttributes><Condition>New</Condition></OfferAttributes><OfferListing><OfferListingId>ZIG%2F06ZQGsBle5gpMc2db%2BoSGNPEMwiLHz30LNC9dRAU6%2BYFMg2tRQhBFyyGAVFIL4Ia1tzSHA5TZcVcdECQfyvS%2BnXT8TuVh%2BUUKUfIw6o%3D</OfferListingId><Price><Amount>11006</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$110.06</FormattedPrice></Price><AmountSaved><Amount>4989</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$49.89</FormattedPrice></AmountSaved><PercentageSaved>31</PercentageSaved><Availability>Usually ships in 24 hours</Availability><AvailabilityAttributes><AvailabilityType>now</AvailabilityType><MinimumHours>0</MinimumHours><MaximumHours>0</MaximumHours></AvailabilityAttributes><IsEligibleForSuperSaverShipping>1</IsEligibleForSuperSaverShipping><IsEligibleForPrime>1</IsEligibleForPrime></OfferListing></Offer></Offers></Item><Item><ASIN>1305959884</ASIN><OfferSummary><LowestNewPrice><Amount>17590</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$175.90</FormattedPrice></LowestNewPrice><LowestUsedPrice><Amount>14500</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$145.00</FormattedPrice></LowestUsedPrice><TotalNew>10</TotalNew><TotalUsed>7</TotalUsed><TotalCollectible>0</TotalCollectible><TotalRefurbished>0</TotalRefurbished></OfferSummary><Offers><TotalOffers>1</TotalOffers><TotalOfferPages>1</TotalOfferPages><MoreOffersUrl>https://www.amazon.com/gp/offer-listing/1305959884?SubscriptionId=AKIAJAPPFUTSV544LJZA&amp;tag=supplytheteac-20&amp;linkCode=xm2&amp;camp=2025&amp;creative=386001&amp;creativeASIN=1305959884</MoreOffersUrl><Offer><Merchant><Name>Amazon.com</Name></Merchant><OfferAttributes><Condition>New</Condition></OfferAttributes><OfferListing><OfferListingId>ZIG%2F06ZQGsDUTV6pK78h%2BRnboiHsXO4L2ZHBuKvmsp1yG4jfD2G9%2BrxAEVx731C2U2budJZYVzzzOoFUcbyta5YNrCt%2FfQqR8HZyGiqW6vwtkzRUKTyy8A%3D%3D</OfferListingId><Price><Amount>17990</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$179.90</FormattedPrice></Price><AmountSaved><Amount>4505</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$45.05</FormattedPrice></AmountSaved><PercentageSaved>20</PercentageSaved><Availability>Usually ships in 24 hours</Availability><AvailabilityAttributes><AvailabilityType>now</AvailabilityType><MinimumHours>0</MinimumHours><MaximumHours>0</MaximumHours></AvailabilityAttributes><IsEligibleForSuperSaverShipping>1</IsEligibleForSuperSaverShipping><IsEligibleForPrime>1</IsEligibleForPrime></OfferListing></Offer></Offers></Item><Item><ASIN>1259657574</ASIN><OfferSummary><LowestNewPrice><Amount>8057</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$80.57</FormattedPrice></LowestNewPrice><LowestUsedPrice><Amount>7254</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$72.54</FormattedPrice></LowestUsedPrice><TotalNew>14</TotalNew><TotalUsed>13</TotalUsed><TotalCollectible>0</TotalCollectible><TotalRefurbished>0</TotalRefurbished></OfferSummary><Offers><TotalOffers>1</TotalOffers><TotalOfferPages>1</TotalOfferPages><MoreOffersUrl>https://www.amazon.com/gp/offer-listing/1259657574?SubscriptionId=AKIAJAPPFUTSV544LJZA&amp;tag=supplytheteac-20&amp;linkCode=xm2&amp;camp=2025&amp;creative=386001&amp;creativeASIN=1259657574</MoreOffersUrl><Offer><Merchant><Name>WiseChoice Books</Name></Merchant><OfferAttributes><Condition>New</Condition></OfferAttributes><OfferListing><OfferListingId>ZIG%2F06ZQGsBXK9hmVum5TF3675QOH%2BFhNPJf13NlrmRMXHISvu2FyVIksg3gqS9RbmiEiv2A%2FCUzQnkMu83N4ii%2BZhP3y6WrcWipmap1ctyi5GRqLgFNKq3H3Mck7hgus4mI1FVT8cm4O2KMc2bxPNCm0P5aSL8z</OfferListingId><Price><Amount>8057</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$80.57</FormattedPrice></Price><Availability>Usually ships in 1-2 business days</Availability><AvailabilityAttributes><AvailabilityType>now</AvailabilityType><MinimumHours>24</MinimumHours><MaximumHours>48</MaximumHours></AvailabilityAttributes><IsEligibleForSuperSaverShipping>0</IsEligibleForSuperSaverShipping><IsEligibleForPrime>0</IsEligibleForPrime></OfferListing></Offer></Offers></Item><Item><ASIN>1118771338</ASIN><OfferSummary><LowestNewPrice><Amount>14210</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$142.10</FormattedPrice></LowestNewPrice><LowestUsedPrice><Amount>7995</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$79.95</FormattedPrice></LowestUsedPrice><TotalNew>15</TotalNew><TotalUsed>29</TotalUsed><TotalCollectible>0</TotalCollectible><TotalRefurbished>0</TotalRefurbished></OfferSummary><Offers><TotalOffers>1</TotalOffers><TotalOfferPages>1</TotalOfferPages><MoreOffersUrl>https://www.amazon.com/gp/offer-listing/1118771338?SubscriptionId=AKIAJAPPFUTSV544LJZA&amp;tag=supplytheteac-20&amp;linkCode=xm2&amp;camp=2025&amp;creative=386001&amp;creativeASIN=1118771338</MoreOffersUrl><Offer><Merchant><Name>Amazon.com</Name></Merchant><OfferAttributes><Condition>New</Condition></OfferAttributes><OfferListing><OfferListingId>ZIG%2F06ZQGsBwX2YAVbVV%2B9YJrCwmGkUGo1vJotiEhnF8cTuy3uBpS8GQqqC2OiCJFmullFvPBtovhiFMaqlEDU%2FPv5chY7YxJAHycs1MaNSVqO27TankOw%3D%3D</OfferListingId><Price><Amount>14210</Amount><CurrencyCode>USD</CurrencyCode><FormattedPrice>$142.10</FormattedPrice></Price><Availability>Usually ships in 24 hours</Availability><AvailabilityAttributes><AvailabilityType>now</AvailabilityType><MinimumHours>0</MinimumHours><MaximumHours>0</MaximumHours></AvailabilityAttributes><IsEligibleForSuperSaverShipping>1</IsEligibleForSuperSaverShipping><IsEligibleForPrime>1</IsEligibleForPrime></OfferListing></Offer></Offers></Item></Items></ItemLookupResponse>';
        String finalResponse = response.remove(response.substringBetween('ItemLookupResponse', '>'));
        system.debug('finalResponse-->'+finalResponse);
        String test = '<?xml version="1.0" ?><ItemLookupResponse xmlns="http://webservices.amazon.com/AWSECommerceService/2011-08-01"><OperationRequest><HTTPHeaders>';    
        Dom.Document doc = new Dom.Document();
        finalWrapper wprObj;
        doc.load(finalResponse);
        //Retrieve the root element for this document.
        Dom.XMLNode itemLookUp = doc.getRootElement();
        if(response.containsIgnoreCase('Items')) {
            if(itemLookUp.getChildElement('Items',null) != null) {
                dom.XmlNode [] itemsLst = itemLookUp.getChildElement('Items',null).getchildelements() ; //Get all Id Elements
                System.debug('itemsLst-->'+itemsLst.size());
                for(Dom.XMLNode item : itemsLst) {
                    if(String.valueof(item.getName()) == 'Request') {
                        if(item.getChildElement('Errors',null) != null) {
							dom.XmlNode [] errorLst = item.getChildElement('Errors',null).getchildelements();
                            for(Dom.XMLNode error : errorLst) {
                                wprObj = new finalWrapper();
                                if(String.valueof(error.getName()) == 'Error') {
                                    String errorMsg = error.getChildElement('Message',null).getText();
                                    System.debug('error-->'+errorMsg);
                                    if(errorMsg.contains(' ')) {
                                        String errorAsin = errorMsg.substring(0, errorMsg.indexOf(' '));
                                        wprObj.asinId = errorAsin;
                                        wprObj.wprLst = new List<xmlWrapper>();
                                    }
                                }
                                finalWprLst.add(wprObj);
                            }
                        }
                    }
                    if(String.valueof(item.getName()) == 'Item') {
                        wprObj = new finalWrapper();
                        if(item.getChildElement('ASIN',null) != null) {
                            String asinVal = item.getChildElement('ASIN',null).getText();
                            wprObj.asinId = asinVal;
                        }
                        if(item.getChildElement('Offers',null) != null) {
                            List<xmlWrapper> xmlWprLst = new List<xmlWrapper>();
                            dom.XmlNode [] offerLst = item.getChildElement('Offers',null).getchildelements() ; //Get all Id Elements
                            if(offerLst.size()>0){
                                for(Dom.XMLNode offer : offerLst) {
                                    if(String.valueof(offer.getName()) == 'Offer'){
                                        xmlWrapper xmlWprObj = new xmlWrapper();
                                        String merchantName = '';
                                        if(offer.getChildElement('Merchant',null) != null && offer.getChildElement('Merchant',null).getChildElement('Name',null)!= null) {
                                            xmlWprObj.merchantName = offer.getChildElement('Merchant',null).getChildElement('Name',null).getText();
                                        }
                                        String offerLstngId = '';
                                        if(offer.getChildElement('OfferListing',null) != null && offer.getChildElement('OfferListing',null).getChildElement('OfferListingId',null)!= null) 
                                            xmlWprObj.OfferListingId = offer.getChildElement('OfferListing',null).getChildElement('OfferListingId',null).getText();
                                        String formatPrice = '';
                                        if(offer.getChildElement('OfferListing',null) != null && offer.getChildElement('OfferListing',null).getChildElement('Price',null)!= null && offer.getChildElement('OfferListing',null).getChildElement('Price',null).getChildElement('FormattedPrice',null)!= null) 
                                            xmlWprObj.Amount= offer.getChildElement('OfferListing',null).getChildElement('Price',null).getChildElement('FormattedPrice',null).getText();
                                        String iSPrime = '';
                                        if(offer.getChildElement('OfferListing',null) != null && offer.getChildElement('OfferListing',null).getChildElement('IsEligibleForPrime',null)!= null) 
                                            xmlWprObj.IsEligibleForPrime = offer.getChildElement('OfferListing',null).getChildElement('IsEligibleForPrime',null).getText();
                                        xmlWprLst.add(xmlWprObj);
                                    }
                                    
                                }
                            }
                            wprObj.wprLst = xmlWprLst;
                            finalWprLst.add(wprObj);
                        }
                    }
                    
                }
            }
            
            
        }
        System.debug('finalWprLst-->'+finalWprLst);
        return getBestOffer(finalWprLst);
    }
    
    /*
* @Author               : Praveen M
* @Description          : Filters the best offer from the list of available offers.
* @Date Of Creation     : 25-Oct-17
* @Modified by          : 
* @Modified Date        : 
* @Modifiction History  :
* @Returns				: 
*/
    public static finalOfferDetails getBestOffer(List<finalWrapper> finalItemsLst) {
        List<BestOfferDetails> bestOfrLst = new List<BestOfferDetails>();
        List<String> noOfferLst = new List<String>();
        for(finalWrapper finalWprObj: finalItemsLst) {
            boolean hasOffer = false;
            List<xmlWrapper> xmlWprObj = finalWprObj.wprLst;
            for(xmlWrapper offerObj : xmlWprObj) {
                String merchant = offerObj.merchantName;
                if(merchant.containsIgnoreCase('amazon')) {
                    hasOffer = true;
                    BestOfferDetails bestOfferObj = new BestOfferDetails();
                    bestOfferObj.asinId = finalWprObj.asinId;
                    bestOfferObj.offer = offerObj;
                    bestOfrLst.add(bestOfferObj);
                }
            }
            if(!hasOffer)
                noOfferLst.add(finalWprObj.asinId);
        }
        finalOfferDetails finalDetails = new finalOfferDetails();
        finalDetails.bestOfferLst = bestOfrLst;
        finalDetails.noOfferLst = noOfferLst;
        return finalDetails;
    }
    
    //Wrapper class to store the data of individual offer.
    public class xmlWrapper {
        public String merchantName;
        public String OfferListingId;
        public String Amount;
        public String IsEligibleForPrime;
    }
    //Wrapper class to store ASIN Id and List of Offers.
    public class finalWrapper {
        public String asinId;
        public List<xmlWrapper> wprLst;
    }
    //Wrapper class to store ASIN Id and Best Offer.
    public class BestOfferDetails {
        public String asinId;
        public xmlWrapper offer;
    }
    //Wrapper class to store BestOfferList and NoOfferList
    public class finalOfferDetails {
        public List<BestOfferDetails> bestOfferLst;
        public List<String> noOfferLst;
    } 
}