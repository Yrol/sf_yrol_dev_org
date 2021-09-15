public class PatientRecovery {
    
    public Integer recoveredInState = 0;
    public static Integer recoveredInCountry = 0;
    public String stateName;
    
    public PatientRecovery(String stateName){
        this();
        this.stateName = stateName;
    }
    
    public PatientRecovery(){
        System.debug('Patient Recovery Program');
    }
    
    public void increaseRecoveries(){
        recoveredInState++;
        recoveredInCountry++;
    }
}