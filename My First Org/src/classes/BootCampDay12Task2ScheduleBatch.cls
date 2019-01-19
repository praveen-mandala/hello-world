/*
 Description : This Apex Class is used to Schedule BootCampDay12
 Author: Praveen Goud
 Date Of Creation: 10-07-2017
 Last Modification: 10-07-2017
 Modification History: null
 */
global class BootCampDay12Task2ScheduleBatch implements Schedulable{

    global void execute(SchedulableContext sc) {
        BootCampDay12Task2 bootCampDay12Task2 = new BootCampDay12Task2();
        database.executebatch(bootCampDay12Task2);

    }
}