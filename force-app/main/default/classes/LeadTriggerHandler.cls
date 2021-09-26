public class LeadTriggerHandler {
    
    public static boolean alreadyExecuted = false;
    
    public static void beforeInsertHandler(List<Lead> newRecords) {
        for(Lead leadRecord: newRecords){
            leadRecord.LeadSource = 'Other';
            /*
            * Making the Industry field mandatory on update
            */
            if(String.isBlank(leadRecord.Industry)){
                leadRecord.addError('The Industry field cannot be blank.');
            }
        }
    }
    
    public static void afterInsertHandler(List<Lead> newRecords) {
        List<Task> tasks = new List<Task>();
        for(Lead leadRecord: newRecords) {
            Tasks.add(new Task(Subject = 'Follow up on Lead Status', WhoId=leadRecord.Id));
        }
        insert tasks;
        
        if(LeadTriggerHandler.alreadyExecuted == false) {
            LeadTriggerHandler.alreadyExecuted = true;
            Lead anotherLead = new Lead(LastName = 'Lead Test Records',
                                   		Status = 'Open - Not Contacted',
                                   		Company = 'Test company');
        
        	insert anotherLead;
        }
    }
    
    public static void beforeUpdatehandler(List<lead> newRecords, Map<Id, Lead> oldRecordsMap) {
        for(Lead leadRecord: newRecords){
            /*
            * Lead will not be allowed to close if the old status is 'Open - Not Contacted'
            * Thowing the error directly on the Status field
            */
            if((leadRecord.Status == 'Closed - Converted' || leadRecord.Status == 'Closed - Not Converted') 
               && oldRecordsMap.get(leadRecord.Id).Status == 'Open - Not Contacted'){
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