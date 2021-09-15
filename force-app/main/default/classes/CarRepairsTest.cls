@isTest
public class CarRepairsTest {
    
    @isTest
    public static void getNumberOfRepairsStateTest(){
        
        Integer totalRepairsCounter = 0;
        
        /***Melbourne***/
        CarRepairs carRepairsMelbourne = new CarRepairs();
        
        for(Integer i = 0; i<=4; i++) {
            carRepairsMelbourne.increaseRepairs();
            totalRepairsCounter++;
        }

        System.assertEquals(5, carRepairsMelbourne.getNumberOfRepairsState(), 'Repair count Melbourne could not match.');
        
        /***Sydeny***/
        CarRepairs carRepairsSydney = new CarRepairs();
        
        for(Integer i = 0; i<=2; i++) {
            carRepairsSydney.increaseRepairs();
            totalRepairsCounter++;
        }
        
        System.assertEquals(3, carRepairsSydney.getNumberOfRepairsState(), 'Repair count Sydney could not match.');
        
        //Total repairs - Sydney and Melbourne
         System.assertEquals(totalRepairsCounter, CarRepairs.getTotalRepairs(), 'Repair count in total.');
    }
}