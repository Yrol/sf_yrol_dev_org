trigger LeadTrigger on Lead (before insert, before update, after update, after insert) {
    
    /*
     * This trigger has been replaced by LeadTriggerV2
    switch on Trigger.operationType {
        when BEFORE_INSERT {
            for(Lead leadRecord: Trigger.new){
                leadRecord.LeadSource = 'Other';
               
                if(String.isBlank(leadRecord.Industry)){
                    leadRecord.addError('The Industry field cannot be blank.');
                }
            }
        }
        
        when AFTER_INSERT {
            List<Task> tasks = new List<Task>();
            for(Lead leadRecord: Trigger.new) {
               Tasks.add(new Task(Subject = 'Follow up on Lead Status', WhoId=leadRecord.Id));
            }
            insert tasks;
        }
        
        when BEFORE_UPDATE {
            for(Lead leadRecord: Trigger.new){
                if((leadRecord.Status == 'Closed - Converted' || leadRecord.Status == 'Closed - Not Converted') 
                   && Trigger.oldMap.get(leadRecord.Id).Status == 'Open - Not Contacted'){
                    leadRecord.Status.addError('You cannot direcly close an Opened lead.');
                }
                
                if(String.isBlank(leadRecord.Industry)){
                    leadRecord.addError('The Industry field cannot be blank.');
                }
            }
        }
    }
	*/
}