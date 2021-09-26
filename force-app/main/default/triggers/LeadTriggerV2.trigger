trigger LeadTriggerV2 on Lead (before insert, before update, after update, after insert) {
    switch on Trigger.operationType {
        when BEFORE_INSERT {
            LeadTriggerHandler.beforeInsertHandler(Trigger.new);
        }
        
        when AFTER_INSERT {
            LeadTriggerHandler.afterInsertHandler(Trigger.new);
        }
        
        when BEFORE_UPDATE {
            LeadTriggerHandler.beforeUpdatehandler(Trigger.new, Trigger.oldMap);
        }
    }
}