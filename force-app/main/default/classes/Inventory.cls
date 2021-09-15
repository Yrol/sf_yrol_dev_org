public class Inventory {
    
    public Integer books = 0;
    public static Integer magazines = 0;
    
    {
        System.debug('Initialization called');
        books = 5;
    }
    
    static {
        System.debug('Static Initialization called');
        magazines = 10;
    }
    
    public void getInventory(){
        System.debug(books);
    }
    
    public Inventory() {
        System.debug('Constructor called');
    }
}