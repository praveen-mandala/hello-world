/*
* @Author               : Gopinadh 
* @Description          : Order Confirmation parsing class
* @Date Of Creation     : 22-Nov-17
* @Modified by          : Gopinadh 
* @Modified Date        : 
* @Modifiction History  :
*/
@RestResource(urlMapping='/OrderConfirmation/*')
global class OrderConfirmationUpdate
{
	@HttpPost
    global static Void doPost()
    {
        Try
        {
            RestRequest req = RestContext.request;
            RestResponse res = RestContext.response;
            res.addHeader('Content-Type', 'application/xml');
            string ReqBody = req.requestBody != null ? req.requestBody.toString() : '';
            string resp = OrderConfirmationXMLParser.ParseOrderConfirmation(ReqBody);
            res.statusCode = 200;
            res.responseBody = Blob.valueof(resp);
        }
        catch(exception e)
        {
            system.debug('Line Number--->'+e.getStackTraceString());
            system.debug('Line Number--->'+e.getMessage());
        }
        
    }
    
}