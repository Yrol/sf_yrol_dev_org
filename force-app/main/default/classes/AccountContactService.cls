public with sharing class AccountContactService {
    
    public static List<Account> UpdateActiveContacts(Set<Id> accountIds, Boolean activeContactResetCheck) {

            
        List<Account> accountsToUpdate = new List<Account>();
        List <AggregateResult> activeContacts = [SELECT AccountId, Count(Id) accountCount FROM Contact WHERE 
                                                 AccountId IN:accountIds AND Active__c = true GROUP BY AccountId];
        
        Set<String> updatedIds = new Set<String>();

        for(AggregateResult result: activeContacts){
            String accountId = String.valueOf(result.get('AccountId'));
            Integer totalContacts = Integer.valueOf(result.get('accountCount'));
            updatedIds.add(accountId);
            accountsToUpdate.add(new Account(Id=accountId, Active_Contacts__c=totalContacts));
        }
        
        /*
         * Making the Active account count to 0 (when deleting and updating if applicable)
         * Making the Active_Contacts__c to 0 for the IDs that were not added to the above accountsToUpdate List.
         * This is because activeContacts query above only selects the Active__c records that are true
         */
        if(activeContactResetCheck) {
            for(Id accountId: accountIds){
                if(!updatedIds.contains(String.valueOf(accountId))) {
                    accountsToUpdate.add(new Account(Id=accountId, Active_Contacts__c=0));
                }
            }
        }

        return accountsToUpdate;
    }
}
