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
@isTest private class CheckingOrigionalContactTest {
    @testSetup static void testData() {
        Account acc = new Account(Name='Tester');
        insert acc;
        List<Contact> listOfContacts = new List<Contact>();
        listOfContacts.add(new Contact(LastName = 'Test', Email = 'test@gmail.com', AccountID = acc.ID));
        listOfContacts.add(new Contact(LastName = 'Test', Email = 'test@gmail.com', AccountID = acc.ID));
        listOfContacts.add(new Contact(LastName = 'Test', Email = 'test@gmail.com', AccountID = acc.ID));
        listOfContacts.add(new Contact(LastName = 'Test1', Email = 'test@gmail.com', AccountID = acc.ID));
        listOfContacts.add(new Contact(LastName = 'Test2', Email = 'test@gmail.com', AccountID = acc.ID));
        insert listOfContacts;
    }
    /**
     *   
     *   @description    :   Checking Origional Contacts and updating values in field Origional Contact and Is Duplicate.
     *
     *   @args           :   none
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 25-03-2022 - Pooja Hemrajani
     * 
     **/
	@isTest static void CheckingOrigionalContact() {
        Test.startTest();
        //RemindOpptyOwners reminder = new RemindOpptyOwners();
        //String sch = '20 30 8 10 2 ?';
        //String jobID = System.schedule('Remind Opp Owners', sch, reminder);
        //
        //CheckingOrigionalContact reminder = new CheckingOrigionalContact();
		//String sch = '0 14 17 25 3 ?';
		//String jobID = System.schedule('Checking Origional Contact New 1', sch, reminder);
		//
        CheckingOrigionalContactBatchClass myBatchObject = new CheckingOrigionalContactBatchClass();
		Id batchId = Database.executeBatch(myBatchObject);
        Test.stopTest();
        Contact[] data = [Select Id, LastName, Email, CreatedDate, Original_Contact__c, Is_Duplicate__c From Contact Where Email != null Order By CreatedDate ASC];
        System.assertEquals(false, data[0].Is_Duplicate__c);
        System.assertEquals(data[0].Id, data[1].Original_Contact__c);
        System.assertEquals(true, data[1].Is_Duplicate__c);
        System.assertEquals(data[0].Id, data[2].Original_Contact__c);
        System.assertEquals(true, data[2].Is_Duplicate__c);
    }
}