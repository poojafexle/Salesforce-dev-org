/**
 *  Description     :  Gentrate csv file of account records and mail it to the address sent updated by user.. 						
 *
 *  Created By      :  Pooja Hemrajani
 *
 *  Created Date    :  12-04-2022
 *
 *  Revision Logs   :  V1.0 - Created - Pooja Hemrajani
 *
 **/
public class genrateCsvFileOfAccountRecords implements
    Database.Batchable<sObject>, Database.Stateful {
    // instance member to retain state across transactions
    public Integer recordsProcessed = 0;
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT ID, Name, BillingStreet, BillingCity, BillingState, ' +
            'BillingPostalCode FROM Account '
        );
    }
    public void execute(Database.BatchableContext bc, List<Account> scope){
        // process each batch of records
        String generatedCSVFile ='';
        generatedCSVFile += 'Id' + ',' + 'Name' + ',' + 'BillingStreet' + ',' + 'BillingCity' + ',' + 'BillingState' + ',' + 'BillingPostalCode' + '\n';
        
        //adding data to csv file
        for(Account acc: scope){
            generatedCSVFile += acc.id + ',' + acc.Name + ',' + acc.BillingStreet + ',' + acc.BillingCity + ',' + acc.BillingState + ',' + acc.BillingPostalCode + '\n';
        }
        Messaging.EmailFileAttachment csvAttachment = new Messaging.EmailFileAttachment();
        Blob csvBlob = blob.valueOf(generatedCSVFile);
        String csvName = 'Accounts data as accounts.csv';
        csvAttachment.setFileName(csvName);
        csvAttachment.setBody(csvBlob);
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[]{'pooja.hemrajani@fexle.com'};
        String subject = 'Accounts data as accounts.csv';
        email.setSubject(subject);
        email.setToAddresses(toAddresses);
        email.setPlainTextBody('Accounts data as accounts.csv');
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