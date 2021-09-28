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
        
        when AFTER_UPDATE {
            Set<Id> accountIds = new Set<Id>();
            for(Contact contactRecord:  Trigger.New) {
                
                Boolean currentActiveStatus = contactRecord.Active__c;
                Boolean oldActiveStatus = Trigger.OldMap.get(contactRecord.Id).Active__c;
                
                /*Check the contact is associated with any account
                 *Check if the current active status is not matching the old (to avoid adding Acounts that have unchanged Active__c)
				 * Also checking in "else if" whether the account ID has been change or not comparing with the old.
                */
                if(String.isNotBlank(contactRecord.AccountId) && (currentActiveStatus != oldActiveStatus)){
                    accountIds.add(contactRecord.AccountId);
                } else if(contactRecord.AccountId != Trigger.OldMap.get(contactRecord.Id).AccountId) {
                    accountIds.add(contactRecord.AccountId);
                    accountIds.add(Trigger.OldMap.get(contactRecord.Id).AccountId);
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