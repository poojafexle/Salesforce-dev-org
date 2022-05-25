@isTest private class ContactTriggerHelperTest {
	@testSetup static void makeData() {
        
    }
    @isTest static void validateAccountField() {
        Test.startTest();
        List<Account> listOfAccounts = new List<Account>();
        for(Integer i=0;i<2;i++) {
            listOfAccounts.add(new Account(Name='Tester'+i));
        }
        insert listOfAccounts;
        List<Contact> listOfContacts = new List<Contact>();
        listOfContacts.add(new Contact(LastName = 'Test1', Status__c = 'Active', AccountID = listOfAccounts[0].Id));
        listOfContacts.add(new Contact(LastName = 'Test2', Status__c = 'In Active', AccountID = listOfAccounts[0].Id));
        listOfContacts.add(new Contact(LastName = 'Test3', AccountID = listOfAccounts[0].Id));
        listOfContacts.add(new Contact(LastName = 'Test4', AccountID = listOfAccounts[0].Id));
        insert listOfContacts;
        
        Account[] acc = [Select Name, Total_Active_Contacts__c, Total_In_Active_Contacts__c From Account];
        System.assertEquals(1, acc[0].Total_In_Active_Contacts__c);
        System.assertEquals(3, acc[0].Total_Active_Contacts__c);
        
        List<Contact> listOfContactsToBeUpdated = new List<Contact>();
        listOfContacts[0].Status__c = 'In Active';
        listOfContacts[0].AccountId = listOfAccounts[1].ID;
        listOfContactsToBeUpdated.add(listOfContacts[0]);
        listOfContacts[2].Status__c = 'In Active';
        listOfContactsToBeUpdated.add(listOfContacts[2]);
        listOfContacts[3].Status__c = 'Active';
        listOfContactsToBeUpdated.add(listOfContacts[3]);
        update listOfContactsToBeUpdated;
        
        Account[] acc1 = [Select Name, Total_Active_Contacts__c, Total_In_Active_Contacts__c From Account];
        System.assertEquals(2, acc1[0].Total_In_Active_Contacts__c);
        System.assertEquals(1, acc1[0].Total_Active_Contacts__c);
        
        System.assertEquals(1, acc1[1].Total_In_Active_Contacts__c);
        System.assertEquals(0, acc1[1].Total_Active_Contacts__c);
        
        delete listOfContacts[0];
        Account[] acc2 = [Select Name, Total_Active_Contacts__c, Total_In_Active_Contacts__c From Account];
        System.assertEquals(2, acc2[0].Total_In_Active_Contacts__c);
        System.assertEquals(1, acc2[0].Total_Active_Contacts__c);
        
        System.assertEquals(0, acc2[1].Total_In_Active_Contacts__c);
        System.assertEquals(0, acc2[1].Total_Active_Contacts__c);
        
        Test.stopTest();
    }
}