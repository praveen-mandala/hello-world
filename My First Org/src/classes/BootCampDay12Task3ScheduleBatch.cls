/*
 Description : This Apex Class is used to Schedule BootCampDay12Task3
 Author: Praveen Goud
 Date Of Creation: 10-07-2017
 Last Modification: 10-07-2017
 Modification History: null
 */
global class BootCampDay12Task3ScheduleBatch implements Schedulable {
    
    global void execute(SchedulableContext sc) {
        BootCampDay12Task3 bootCampDay12Task3 = new BootCampDay12Task3(4);
        database.executebatch(bootCampDay12Task3);
    }
    
}