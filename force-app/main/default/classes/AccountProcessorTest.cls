@isTest
private class AccountProcessorTest {
    @testSetup static void countContactsData() {
        List<Account> listOfAccounts = new List<Account>();
        listOfAccounts.add(new Account(Name = 'Test 1'));
        listOfAccounts.add(new Account(Name = 'Test 2'));
        listOfAccounts.add(new Account(Name = 'Test 3'));
        listOfAccounts.add(new Account(Name = 'Test 4'));
        listOfAccounts.add(new Account(Name = 'Test 5'));
        insert listOfAccounts;
        List<Contact> listOfContacts = new List<Contact>();
        for(Account acct: listOfAccounts) {
            listOfContacts.add(new Contact(AccountId = acct.Id, FirstName = 'Test', LastName = '1', Email='test@1.com'));
            listOfContacts.add(new Contact(AccountId = acct.Id, FirstName = 'Test', LastName = '2', Email='test@2.com'));
            listOfContacts.add(new Contact(AccountId = acct.Id, FirstName = 'Test', LastName = '3', Email='test@3.com'));
        }
        insert listOfContacts;
    }
    @isTest static void countContacts() {
        List<Account> dataOfAccounts = [Select Id From Account];
        List<Id> listOfIds = new List<Id>();
        for(Account acc: dataOfAccounts) {
            listOfIds.add(acc.Id);
        }
        Test.startTest();
        AccountProcessor.countContacts(listOfIds);
        Test.stopTest();
    }
}