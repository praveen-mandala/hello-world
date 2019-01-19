/*
* @Author               : Praveen M
* @Description          : Schedules the batch class to update the product prices for every 15 mins.
* @Date Of Creation     : 30-Oct-17
* @Modified by          : 
* @Modified Date        : 
* @Modifiction History  :
*/
public class SchedulePriceUpdates implements Schedulable {
    
    public void execute(System.SchedulableContext ctx){
        UpdateProductBatch obj = new UpdateProductBatch();
        Database.executeBatch(obj,10);//Sends 10 products at once.
    }
}