public class AccountsController {
    
    public static List<Account> addAccounts(List<Account> accounts) {
        insert accounts;
        return accounts;
    }
    
    public static Account addAccount(Account acc) {
        insert acc;
        return acc;
    }
    
    public static List<Account> getAllAccounts() {
        List<Account> accounts = [SELECT Name, Phone from Account];
        return accounts;
    }
    
    public static void showAccounts(){
        List<Account> accounts = getAllAccounts();
        
        for(Account account: accounts){
            System.debug('Name:' + account.Name + ' Phone:' + account.Phone);
        }
    }

}