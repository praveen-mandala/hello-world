/*** Controller ***/
public class documentExt {
    public string fileName{get;set;}
    public transient Blob filebody{get;set;}
    /*public documentExt(ApexPages.StandardController controller) {
        Document d = (Document) controller.getRecord();
        d.folderid = UserInfo.getUserId(); //this puts it in My Personal Documents
    } */
    
    public void upload() {
		String existingBody = EncodingUtil.base64Encode(filebody);
        System.debug('existingBody-->'+existingBody);
        
        String strbase64Data = EncodingUtil.urlDecode(existingBody, 'UTF-8');
        
        Document doc = new Document();
        doc.Body = EncodingUtil.base64Decode(existingBody);
        doc.ContentType = 'application/pdf';
        doc.Name = 'StringToPDFVF';
        doc.FolderId = '0057F000000p9qe';
        insert doc;
        
    } 
}