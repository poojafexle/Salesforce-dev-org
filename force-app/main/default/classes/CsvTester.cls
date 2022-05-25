public class CsvTester {
    public static void setAccountRating() {
        //List<company__c> extractcompanyMemList = new List<company__c>();
        //List<company__c> companytList = [select id,name,(select id from companymemebers__r) from company__c];
        //, (SELECT ID, Name MailingStreet, MailingCity, ' + 'MailingState, MailingPostalCode FROM Contacts)
        Account[] data = [select FIELDS(STANDARD) from account];
        
        String generatedCSVFile ='';
        List<String> queryFields = new List<String>{'Id','Name'};
            String fileRow = '';
        
        for(Account acc: data){
            generatedCSVFile += acc + '\n';
            //for(Contact con: acc.Contacts) {
                //generatedCSVFile += acc.id + ',' + acc.Name+ ',' + con.id + ',' + con.name + '\n'; 
            //}
        }
        
        System.debug(generatedCSVFile);
        
        Messaging.EmailFileAttachment csvAttachment = new Messaging.EmailFileAttachment();
        Blob csvBlob = blob.valueOf(generatedCSVFile);
        String csvName = 'company details which does not have members.csv';
        csvAttachment.setFileName(csvName);
        csvAttachment.setBody(csvBlob);
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[]{'pooja.hemrajani@fexle.com'};
        String subject = 'company details which does not have members CSV';
        email.setSubject(subject);
        email.setToAddresses(toAddresses);
        email.setPlainTextBody('company details which does not have members CSV');
        email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttachment});
        //Messaging.SendEmailResult[] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
    }
}