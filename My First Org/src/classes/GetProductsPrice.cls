/*
* @Author               : Praveen M
* @Description          : Gets Products from Batch and updates the Price after calling the AWS.
* @Date Of Creation     : 24-Oct-17
* @Modified by          : 
* @Modified Date        : 
* @Modifiction History  :
*/
public class GetProductsPrice {

    /*
* @Author               : Praveen M
* @Description          : Prepares String of Product Codes and call the ProductAPIClient
* @Date Of Creation     : 24-Oct-17
* @Modified by          : 
* @Modified Date        : 
* @Modifiction History  :
* @Returns				: 
*/
    
    public static void getProductDetails(List<Product2> productLst) {
        //String of productCodes seperated by ",".
        List<String> prodCodes = new List<String>();
        //List<Product2> productLst = [Select Id,ProductCode,Name from Product2 Where ProductCode != ''];
        //List<PricebookEntry> priceBookLst = [Select Product2.Id,Product2.ProductCode,Pricebook2.Id,Product2.Name,UnitPrice from PricebookEntry LIMIT 10];
        for(Product2 prod : productLst) {
            prodCodes.add(prod.ProductCode);
        }
        System.debug('prodCodes-->'+prodCodes);
        String codeStr = '';
        for(String code : prodCodes) {
            codeStr += code + ',';
        }
        String newStr = codeStr.subString(0 , codeStr.length()-1);
        System.debug('newStr-->'+newStr);
        ProductAPIClient productApiObj = new ProductAPIClient();
        updatePriceDetails(productApiObj.getOfferDetails(newStr));
        
    }
    
    /*
* @Author               : Praveen M
* @Description          : Updates the Products with price and also the Last Synced Date/Time
* @Date Of Creation     : 30-Oct-17
* @Modified by          : 
* @Modified Date        : 
* @Modifiction History  :
* @Returns				: 
*/
    public static void updatePriceDetails(ProductAPIClient.finalOfferDetails finalDetailsObj) {
        List<ProductAPIClient.BestOfferDetails> bestOffersLst = finalDetailsObj.bestOfferLst;
        List<String> noOffers = finalDetailsObj.noOfferLst;
        List<Id> productToUpdateLst = new List<Id>();
        //List<PricebookEntry> priceBookLst = [Select Product2.Id,Product2.ProductCode,Pricebook2.Id,Product2.Name,UnitPrice from PricebookEntry];
        Id standardId = [Select Id,Name From Pricebook2 where Name = 'Standard Price Book'].Id;
        List<PricebookEntry> pbEntryList = [SELECT Id, UnitPrice, Product2Id,Product2.ProductCode,Product2.Last_Synced_On__c ,Pricebook2Id, Name, IsActive, ProductCode FROM PricebookEntry];
        System.debug('pbEntryList11-->'+pbEntryList);
        Set<Id> pbList = new Set<Id>();  
        for(PricebookEntry pbe : pbEntryList){  
            pbList.add(pbe.Product2Id);
        }
        List<PricebookEntry> pbeList = new List<PricebookEntry>(); 
        List<PricebookEntry> pbeListToUpdate = new List<PricebookEntry>(); 
        for(Product2 p: [Select Id, Name , ProductCode FROM Product2 WHERE Id NOT IN : pbList]){  
            // place you PriceBook2Id below
            for(ProductAPIClient.BestOfferDetails bestOffer : bestOffersLst) {
                if(bestOffer.asinId == p.ProductCode) {
                    String amt = bestOffer.offer.Amount;
                    String bestAmt = amt.substringAfter('$');
                    pbeList.add(new PricebookEntry(UnitPrice = Decimal.valueOf(bestAmt) , Pricebook2Id = standardId, product2Id = p.Id,isActive = true));
                    productToUpdateLst.add(p.Id);
                }
            }
            //p.Last_Synced_On__c= System.now();
            
        }
        
         for(PricebookEntry pbEntry2 : pbEntryList) {
            for(ProductAPIClient.BestOfferDetails bstOfferObj : bestOffersLst) {
                if(bstOfferObj.asinId == pbEntry2.Product2.ProductCode) {
                    System.debug('bstOfferObj.offer.Amount-->'+bstOfferObj.offer.Amount);
                    System.debug('bstOfferObj.offer.productid-->'+pbEntry2.Product2id);
                    String amt = bstOfferObj.offer.Amount;
                    String bestAmt = amt.substringAfter('$');
                    pbEntry2.UnitPrice = Decimal.valueOf(bestAmt);
                    pbeListToUpdate.add(pbEntry2);
                    productToUpdateLst.add(pbEntry2.Product2Id);
                }
            }
        }
        List<Product2> prodLst = [Select Id,ProductCode,Name,Last_Synced_On__c from Product2 Where ID IN :productToUpdateLst AND ID NOT IN :noOffers];
        System.debug('prodLst-->'+prodLst.size());
        System.debug('prodLst-->'+prodLst);
        for(ProductAPIClient.BestOfferDetails bstOfferObj : bestOffersLst) {
            for(Product2 prod : prodLst) {
                prod.Last_Synced_On__c = System.now();
                prod.Offer_Id__c = bstOfferObj.offer.OfferListingId;
            }
        }
        
        System.debug('noOffers-->'+noOffers);
        if(noOffers.size() > 0)
            //sendEmailNotification(noOffers);
        System.debug('pbEntryList-->'+pbEntryList);
        System.debug('pbeList-->'+pbeList);
        //update pbEntryList;
        update pbeListToUpdate;
        insert pbeList;
        update prodLst;
    }
    
    /*
* @Author               : Praveen M
* @Description          : Sends an email notification to User containing details of products which are not updated.
* @Date Of Creation     : 30-Oct-17
* @Modified by          : 
* @Modified Date        : 
* @Modifiction History  :
* @Returns				: 
*/
    public static void sendEmailNotification(List<String> noOffers) {
        String emailId = User_Email__c.getInstance('EmailId').Value_Email__c;
        List<Product2> prodLst = [Select Id,ProductCode,Name,Last_Synced_On__c from Product2 Where ProductCode IN :noOffers];
        String body = 'Below are the Products which are not updated';
        for(Product2 prod : prodLst) {
            
            body += '<br/>';
            body += 'Name: ';
            body += prod.Name + ', ';
            body += 'Product Code: ';
            body += prod.ProductCode;
            
        }
        List<Messaging.SingleEmailMessage> mails = 
            new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail = 
            new Messaging.SingleEmailMessage();
        List<String> sendTo = new List<String>();
        sendTo.add(emailId);
        mail.setToAddresses(sendTo);
        mail.setSenderDisplayName('Product Information');
        mail.setSubject('Product Information');
        mail.setHtmlBody(body);
        mails.add(mail);
        Messaging.sendEmail(mails);
    }
}