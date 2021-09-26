trigger LeadTrigger on Lead (before insert, before update, after update, after insert) {
    
    switch on Trigger.operationType {
        when BEFORE_INSERT {
            for(Lead leadRecord: Trigger.new){
                leadRecord.LeadSource = 'Other';
                
                /*
                * Making the Industry field mandatory on update
				*/
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
                 /*
                 * Lead will not be allowed to close if the old status is 'Open - Not Contacted'
                 * Thowing the error directly on the Status field
                */
                if((leadRecord.Status == 'Closed - Converted' || leadRecord.Status == 'Closed - Not Converted') 
                   && Trigger.oldMap.get(leadRecord.Id).Status == 'Open - Not Contacted'){
                    leadRecord.Status.addError('You cannot direcly close an Opened lead.');
                }
                
                /*
                 * Making the Industry field mandatory on update
				*/
                if(String.isBlank(leadRecord.Industry)){
                    leadRecord.addError('The Industry field cannot be blank.');
                }
            }
        }
    }
}