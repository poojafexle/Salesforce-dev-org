public class LeadProcessor implements
    Database.Batchable<sObject>, Database.Stateful {
	// instance member to retain state across transactions
    public Integer recordsProcessed = 0;
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT ID, LeadSource FROM Lead'
        );
    }
    public void execute(Database.BatchableContext bc, List<Lead> scope){
        // process each batch of records
        List<Lead> listOfLeads = new List<Lead>();
        for (Lead record : scope) {
            record.LeadSource = 'Dreamforce';
            // add contact to list to be updated
            listOfLeads.add(record);
            // increment the instance member counter
            recordsProcessed = recordsProcessed + 1;
        }
        update listOfLeads;
    }
    public void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed. Shazam!');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        // call some utility to send email
        //EmailUtils.sendMessage(job, recordsProcessed);
    }
}