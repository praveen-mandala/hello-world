/*
* @Author               : Praveen M
* @Description          : Batch class to send list of products to Product Avertising API
* @Date Of Creation     : 30-Oct-17
* @Modified by          : 
* @Modified Date        : 
* @Modifiction History  :
*/
global class UpdateProductBatch implements Database.Batchable<sObject>,Database.AllowsCallouts, Database.Stateful{
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        // collect the batches of records or objects to be passed to execute
        String query = 'Select Id,ProductCode,Name from Product2 Where ProductCode != \' \'';
        //String query = 'Select Id,ProductCode,Name from Product2 Where ProductCode != ''';
        System.debug('query-->'+query);
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Product2> productLst) {
        System.debug('productLstBatch-->'+productLst);
        GetProductsPrice.getProductDetails(productLst);
    }   
    
    global void finish(Database.BatchableContext BC) {
        // execute any post-processing operations
        System.debug('Batch Completed');
    }
}