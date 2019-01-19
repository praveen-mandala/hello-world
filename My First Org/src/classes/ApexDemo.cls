public class ApexDemo {

    public void display(){

        String Name = 'abc123';
       List<Account> accList = [Select id,Name From Account Where Name=:Name];
        for(Integer i=0;i<accList.size();i++){
            System.debug(accList[i]);
        }
        System.debug('Hello World!!');
    }
}