public class LightningEventsCntrl {

    @AuraEnabled
    public static void throwError() {
        throw new AuraHandledException('Hello this is exception');
    }
}