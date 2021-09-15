public class UpdateResolutionsDays {
    
    //accepting a lis of accounts
    public static void updateResolution(List<Account> accounts){
        
        Map<Id, Integer> accountTotalCaseMap = new Map<Id, Integer>();
        Map<Id, Integer> accountTotalCaseDaysMap = new Map<Id, Integer>();
        
        List<Id> accIds = new List<Id>();
        
        for(Account acc: accounts){
            accIds.add(acc.Id);
        }
        
        List<Case> cases = [SELECT Id, AccountId, ClosedDate, CreatedDate FROM Case WHERE IsClosed = true AND AccountId IN: accIds];
        
        accIds = null;
        
        for(Case caseObj: cases){
            if(!accountTotalCaseMap.containsKey(caseObj.AccountId)){
                accountTotalCaseMap.put(caseObj.AccountId, 0);
                accountTotalCaseDaysMap.put(caseObj.AccountId, 0);
            }
            
            Integer totalCases = accountTotalCaseMap.get(caseObj.AccountId);
            totalCases++;
            accountTotalCaseMap.put(caseObj.AccountId, totalCases);
            
            Integer totalDays = accountTotalCaseDaysMap.get(caseObj.AccountId);
            totalDays += caseObj.CreatedDate.date().daysBetween(caseObj.ClosedDate.date());
            accountTotalCaseDaysMap.put(caseObj.AccountId, totalDays);
        }
        
       	List<Account> accountsToUpdate = new List<Account>();
        for(Id accountId: accountTotalCaseMap.keySet()) {
            Decimal resolutionDays = accountTotalCaseDaysMap.get(accountId)/accountTotalCaseMap.get(accountId);
            accountsToUpdate.add(new Account(Id=accountId, Avg_CaseResolution_days__c = resolutionDays));
        }
        
        System.debug(accountTotalCaseMap);
        update accountsToUpdate;
    }
}