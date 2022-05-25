/**
 *  Description     :  Gentrate csv file of account and related contact records and mail it to the address sent updated by user.. 						
 *
 *  Created By      :  Pooja Hemrajani
 *
 *  Created Date    :  12-04-2022
 *
 *  Revision Logs   :  V1.0 - Created - Pooja Hemrajani
 *
 **/
public class genrateCsvFileOfAccountContactRecords implements
    Database.Batchable<sObject>, Database.Stateful {
    // instance member to retain state across transactions
    public Integer recordsProcessed = 0;
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT ID, Name, (SELECT ID, Name FROM Contacts) FROM Account '
        );
    }
    public void execute(Database.BatchableContext bc, List<Account> scope){
        // process each batch of records
        String generatedCSVFile ='';
        generatedCSVFile += 'Id' + ',' + 'Name' + ',' + 'Contact Id' + ',' + 'Contact Name' + '\n';
        
        //add data to csv file
        for(Account acc: scope){
            Integer counter = 0;
            for(Contact con: acc.Contacts){
                if(counter == 0) {
             		generatedCSVFile += acc.id + ',' + acc.Name + ',' + con.id + ',' + con.Name + '\n';       
                } else {
                    generatedCSVFile +=  ' ' + ',' + ' ' + ',' + con.id + ',' + con.Name + '\n';
                }
                counter++;
            }
        }
        Messaging.EmailFileAttachment csvAttachment = new Messaging.EmailFileAttachment();
        Blob csvBlob = blob.valueOf(generatedCSVFile);
        String csvName = 'Accounts and Contacts data as accountsContacts.csv';
        csvAttachment.setFileName(csvName);
        csvAttachment.setBody(csvBlob);
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[]{'pooja.hemrajani@fexle.com'};
        String subject = 'Accounts and Contacts data as accountsContacts.csv';
        email.setSubject(subject);
        email.setToAddresses(toAddresses);
        email.setPlainTextBody('Accounts and Contacts data as accountsContacts.csv');
        email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttachment});
        Messaging.SendEmailResult[] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
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