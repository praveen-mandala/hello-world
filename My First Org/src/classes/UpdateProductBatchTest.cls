@isTest
public class UpdateProductBatchTest {
    //Test Method to excute theBccEmailnChatterBatch class 
    static testMethod void method1(){
        ProductAPIDetails__c pad = new ProductAPIDetails__c(name = 'Test');
        insert pad;
        //Shipping_Confirmation__c sc = new Shipping_Confirmation__c(name ='Amazon',Confirmation_Email__c='gopinadh.sonti@gmail.com');
        //insert sc;
        Pricebook2 customPB = new Pricebook2(Name='Standard Price Book', isActive=true);
        insert customPB;
        List<Product2> proList = new List<Product2>();
        for (integer i = 0 ; i<=9 ;i++)
        {
         proList.add(new Product2(Name= 'Test'+i,ProductCode='123'+i));    
        }
        insert proList;
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ProductAPIMock());
        UpdateProductBatch obj = new UpdateProductBatch();
        DataBase.executeBatch(obj,10);
        //system.debug('Email Adresss ---->'+[select Confirmation_Email__c from Shipping_Confirmation__c].Confirmation_Email__c);
        Test.stopTest();
    }
}