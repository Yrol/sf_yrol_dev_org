public with sharing class ContactTriggerHandler {

    public static void afterInsertHandler(List<Contact> newContacts) {
        Set<Id> accountIds = new Set<Id>();
        for(Contact contactRecord:  newContacts) {
            //check the contact is associated with any account
            if(String.isNotBlank(contactRecord.AccountId)){
                accountIds.add(contactRecord.AccountId);
            }
        }

        List<Account> accountsToUpdate = AccountContactService.UpdateActiveContacts(accountIds, false);
        
        update accountsToUpdate;
    }

    public static void afterUpdateHandler(List<Contact> newContacts, Map<Id, Contact> oldRecordMap) {

        Set<Id> accountIds = new Set<Id>();
            for(Contact contactRecord: newContacts) {  
                /*Check the contact is associated with any account
                *Check if the current active status is not matching the old (to avoid adding Acounts that have unchanged Active__c)
                * Also checking in "else if" whether the account ID has been change or not comparing with the old.
                */
                if(String.isNotBlank(contactRecord.AccountId) && 
                   contactRecord.Active__c != oldRecordMap.get(contactRecord.Id).Active__c){
                       accountIds.add(contactRecord.AccountId);
                   } else if(contactRecord.AccountId != oldRecordMap.get(contactRecord.Id).AccountId) {
                       accountIds.add(contactRecord.AccountId);
                       accountIds.add(oldRecordMap.get(contactRecord.Id).AccountId);
                   }
            }

            List<Account> accountsToUpdate = AccountContactService.UpdateActiveContacts(accountIds, true);
        
            update accountsToUpdate;
    }

    public static void afterDeleteHandler(List<Contact> oldContacts) {

        Set<Id> accountIds = new Set<Id>();
        for(Contact contactRecord:  oldContacts) {
            //check the contact is associated with any account
            if(String.isNotBlank(contactRecord.AccountId)){
                accountIds.add(contactRecord.AccountId);
            }
        }

        List<Account> accountsToUpdate = AccountContactService.UpdateActiveContacts(accountIds, true);
        
        update accountsToUpdate;
    }

    public static void afterUnDeleteHandler(List<Contact> newContacts) {

        Set<Id> accountIds = new Set<Id>();
        for(Contact contactRecord:  newContacts) {
            //check the contact is associated with any account
            if(String.isNotBlank(contactRecord.AccountId)){
                accountIds.add(contactRecord.AccountId);
            }
        }

        List<Account> accountsToUpdate = AccountContactService.UpdateActiveContacts(accountIds, false);
        
        update accountsToUpdate;
    }
}
