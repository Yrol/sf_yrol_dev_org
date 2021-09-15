public class BillCalculation {
    
    private Integer per_one_slice = 8;
    private Integer per_two_to_three_slice = 7;
    private Integer per_three_or_more_silce = 6;
    private Integer total = 0;
    
    public String calculate(Integer noOfSilces, String name){
       total = noOfSilces == 1 ? noOfSilces*per_one_slice : 
        	   noOfSilces > 3 ? noOfSilces * per_three_or_more_silce : 
        	   noOfSilces * per_two_to_three_slice;
        
       return 'Total for ' + name + ' is ' + total;
    }
}