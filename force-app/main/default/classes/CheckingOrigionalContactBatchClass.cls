/**
 *  Description     :  Checking Origional Contacts and updating values in field Origional Contact and Is Duplicate. 						
 *
 *  Created By      :  Pooja Hemrajani
 *
 *  Created Date    :  25-03-2022
 *
 *  Revision Logs   :  V1.0 - Created - Pooja Hemrajani
 *
 **/
public class CheckingOrigionalContactBatchClass implements
    Database.Batchable<sObject> {
    // instance member to retain state across transactions
    public Integer recordsProcessed = 0;
        
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'Select Id, LastName, Email, CreatedDate, Original_Contact__c, Is_Duplicate__c From Contact Where Email != null AND Is_Duplicate__c = true Order By CreatedDate ASC'
        );
    }
    public void execute(Database.BatchableContext bc, List<Contact> scope){
        // process each batch of records
        List<Contact> contacts = new List<Contact>();
        Map<String, Contact> mapOfData = new Map<String, Contact>();
        for (Contact con : scope) {
            if(!mapOfData.containsKey(con.LastName+con.Email)) {
                mapOfData.put((con.LastName+con.Email), con);
            } 
            else if(mapOfData.containsKey(con.LastName+con.Email)) {
                if(mapOfData.get(con.LastName+con.Email) != con) {
                    con.Is_Duplicate__c = true;
                    con.Original_Contact__c = mapOfData.get(con.LastName+con.Email).Id;
                    contacts.add(con);
                    // increment the instance member counter
                    recordsProcessed = recordsProcessed + 1;
                }
            }
        }
        if(contacts.size()>0) {
            update contacts;
        }
    }
    public void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed!');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        	// call some utility to send email
        	// EmailUtils.sendMessage(job, recordsProcessed);
    }
}