trigger ContactTrigger on Contact (after insert, after update, after delete, after undelete) {
    
    switch on Trigger.operationType {
        when AFTER_INSERT {
            Set<Id> accountIds = new Set<Id>();
            for(Contact contactRecord:  Trigger.New) {
                //check the contact is associated with any account
                if(String.isNotBlank(contactRecord.AccountId)){
                    accountIds.add(contactRecord.AccountId);
                }
            }
            
            List<Account> accountsToUpdate = new List<Account>();
            List <AggregateResult> accountResults = [SELECT AccountId, Count(Id) accountCount FROM Contact WHERE 
    												AccountId IN:accountIds AND Active__c = true GROUP BY AccountId];
            
            for(AggregateResult result: accountResults){
                String accountId = String.valueOf(result.get('AccountId'));
                Integer totalContacts = Integer.valueOf(result.get('accountCount'));
                accountsToUpdate.add(new Account(Id=accountId, Active_Contacts__c=totalContacts));
            }
            
            update accountsToUpdate;
        }
    }
}