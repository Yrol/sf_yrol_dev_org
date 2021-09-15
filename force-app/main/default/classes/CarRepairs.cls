public class CarRepairs {

    public Integer numberOfRepairsState = 0;
    public static Integer numberOfRepairsTotal = 0;
 
    public void increaseRepairs() {
        numberOfRepairsState++;
        numberOfRepairsTotal++;
    }
    
    public Integer getNumberOfRepairsState(){
        return numberOfRepairsState;
    }
    
    public static Integer getTotalRepairs() {
        return numberOfRepairsTotal;
    }
}