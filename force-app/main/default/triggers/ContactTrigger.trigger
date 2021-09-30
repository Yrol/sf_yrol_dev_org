trigger ContactTrigger on Contact (after insert, after update, after delete, after undelete) {
    
    switch on Trigger.operationType {
        when AFTER_INSERT {
            ContactTriggerHandler.afterInsertHandler(Trigger.New);
        }
        
        when AFTER_UPDATE {
            ContactTriggerHandler.afterUpdateHandler(Trigger.New, Trigger.oldMap);
        }
    }
}