public class GetWeekDay {
    
    public void getDay(Integer dayNumber)
    {
        switch on dayNumber {
            when 1 {
                System.debug('Sunday');
            }
            when 2 {
                System.debug('Monday');
            }
            when 3 {
                System.debug('Tuesday');
            }
            when 4 {
                System.debug('Wednesday');
            }
            when 5 {
                System.debug('Thusrday');
            }
            when 6 {
                System.debug('Friday');
            }
            when 7 {
                System.debug('Saturday');
            } 
            when else {
                 System.debug('Invald');
            }
        }
    } 
}