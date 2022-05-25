/**
 *  Description     :  Trigger test class on account. 						
 *
 *  Created By      :  Pooja Hemrajani
 *
 *  Created Date    :  07-03-2022
 *
 *  Revision Logs   :  V1.0 - Created - Pooja Hemrajani
 * 					   V1.1 - 16-03-2022 - added a function -> createContactAccordingToString - Pooja Hemrajani
 *
 **/
@isTest
private class TriggerAccountTest {
    
    @isTest static void updateAccountNumber() {
        Test.startTest();
        List<Account> listOfAccounts = new List<Account>();
        listOfAccounts.add(new Account(Name = 'Test1', Rating = 'Hot'));
        listOfAccounts.add(new Account(Name = 'Test2', Rating = 'Cold'));
        listOfAccounts.add(new Account(Name = 'Test3', Rating = 'Warm'));
        listOfAccounts.add(new Account(Name = 'Test4'));
        insert listOfAccounts;
        
        Account[] acc = [Select Name, Rating, AccountNumber From Account];
        System.assertEquals('1', acc[0].AccountNumber);
        System.assertEquals('1234', acc[1].AccountNumber);
        System.assertEquals('0', acc[3].AccountNumber);
        
        List<Account> listOfAccountsToBeUpdated = new List<Account>();
        for(Integer i=0; i<4; i++) {
            listOfAccounts[i].Name = 'Update test '+ i;
            listOfAccounts[i].rating = 'Hot';
            listOfAccountsToBeUpdated.add(listOfAccounts[i]);
        }
        update listOfAccountsToBeUpdated;
        Account[] acc1 = [Select Name, Rating, AccountNumber From Account];
        System.assertEquals('1', acc1[0].AccountNumber);
        System.assertEquals('1', acc1[1].AccountNumber);
        System.assertEquals('1', acc1[3].AccountNumber);
        Test.stopTest();
  
    }
    
    @isTest static void ValidateAccountField() {
        Test.startTest();
        try{
            List<Account> listOfAccounts = new List<Account>();
            listOfAccounts.add(new Account(Name = 'Test1', Active__c = 'Yes', In_Active_Reason__c = 'yes'));
            listOfAccounts.add(new Account(Name = 'Test1', Active__c = 'No', In_Active_Reason__c = 'yes'));
            listOfAccounts.add(new Account(Name = 'Test2', Active__c = 'No'));
            listOfAccounts.add(new Account(Name = 'Test3', In_Active_Reason__c = 'yes'));
            insert listOfAccounts;
            Account[] newListOfAccounts = [Select Name, Active__c, In_Active_Reason__c, Rating, AccountNumber From Account];
            List<Account> listOfAccountsToBeUpdated = new List<Account>();
            for(Integer i=0; i<1; i++) {
                newListOfAccounts[i].Active__c = 'No';
                newListOfAccounts[i].In_Active_Reason__c = 'No';
                listOfAccountsToBeUpdated.add(listOfAccounts[i]);
            }
            for(Integer i=1; i<2; i++) {
                newListOfAccounts[i].Active__c = 'No';
                newListOfAccounts[i].In_Active_Reason__c = 'No';
                listOfAccountsToBeUpdated.add(listOfAccounts[i]);
            }
            for(Integer i=2; i<4; i++) {
                newListOfAccounts[i].Active__c = 'No';
                listOfAccountsToBeUpdated.add(listOfAccounts[i]);
            }
            update listOfAccountsToBeUpdated;
        }
        catch(Exception e) {

            System.Assert(e.getMessage().contains('Please select In Active Reason for the Account.'));

        }
     	Test.stopTest();
    }
    
    @isTest static void createContactAccordingToString() {
        Test.startTest();
        List<Account> listOfAccounts = new List<Account>();
        listOfAccounts.add(new Account(Name = 'Test1',Contact_Details__c='FirstName = Tester, LastName = 1, Email = tester1@gmail.com', Contact_Details_1__c='FirstName = Tester, LastName = 2, Email = tester2@gmail.com'));
        listOfAccounts.add(new Account(Name = 'Test2',Contact_Details__c='FirstName = Tester, LastName = 3, Email = tester3@gmail.com', Contact_Details_1__c='FirstName = Tester, LastName = 4, Email = tester4@gmail.com'));
        listOfAccounts.add(new Account(Name = 'Test3',Contact_Details__c='FirstName = Tester, LastName = 5, Email = tester5@gmail.com', Contact_Details_1__c='FirstName = Tester, LastName = 6, Email = tester6@gmail.com'));
        listOfAccounts.add(new Account(Name = 'Test4',Contact_Details__c='FirstName = Tester, LastName = 5, Email = tester5@gmail.com'));
        listOfAccounts.add(new Account(Name = 'Test5',Contact_Details_1__c='FirstName = Tester, LastName = 6, Email = tester6@gmail.com'));
        listOfAccounts.add(new Account(Name = 'Test6'));
        listOfAccounts.add(new Account(Name = 'Test7',Contact_Details__c='FirstName = Tester, Email = tester5@gmail.com', Contact_Details_1__c='FirstName = Tester, LastName = 6, Email = tester6@gmail.com'));
        insert listOfAccounts;
        Account[] data = [Select Id, Name, Contact_Details__c, (Select Id, FirstName, LastName, Email, Previous_Account__c From Contacts) From Account Where Id IN: listOfAccounts];
        String conn1 = 'FirstName = Tester, LastName = 1, Email = tester1@gmail.com';
        String conn2 = 'FirstName = Tester, LastName = 2, Email = tester1@gmail.com';
        Map<String, Contact> mapOfData = new Map<String, Contact>();
        List<String> listOfData = new List<String>();
        for(Account acc: data) {
            for(Contact con: acc.Contacts) {
                listOfData.add('FirstName = '+con.FirstName+', LastName = '+con.LastName+', Email = '+con.Email);
            }
        }
        if(listOfData.contains(conn1) && listOfData.contains(conn2)) {
            System.assertEquals((conn1+conn2), (listOfData[0].trim()+listOfData[1].trim()));
        }
        
        List<Contact> listOfContacts = new List<Contact>();
        for(Account acc: listOfAccounts) {
            listOfContacts.add(new Contact(FirstName='Tester',LastName = 'new', Email = 'tester1@gmail.com', AccountId = acc.Id));
            listOfContacts.add(new Contact(FirstName='Test',LastName = '1', Email = 'test1@gmail.com', AccountId = acc.Id));
        }
        insert listOfContacts;
        for(Account acc: listOfAccounts) {
            acc.Contact_Details__c='FirstName = Tester, LastName = Updated, Email = tester1@updated.com';
            acc.Contact_Details_1__c='FirstName = Test, LastName = Updated, Email = tester1@updated.com';
        }
        update listOfAccounts;
        data = [Select Id, Name, Contact_Details__c, (Select Id, FirstName, LastName, Email, Previous_Account__c From Contacts) From Account Where Id IN: listOfAccounts];
        conn1 = 'FirstName = Tester, LastName = Updated, Email = tester1@updated.com';
        conn2 = 'FirstName = Test, LastName = Updated, Email = tester1@updated.com';
        listOfData = new List<String>();
        for(Contact con: data[0].Contacts) {
            listOfData.add('FirstName = '+con.FirstName+', LastName = '+con.LastName+', Email = '+con.Email);
        }
        System.assert(listOfData.contains(conn1));
        System.assert(listOfData.contains(conn2));
        
        Account[] acct = [Select Id, Name, Contact_Details__c, Contact_Details_1__c, (Select Id, FirstName, LastName, Email, Previous_Account__c From Contacts) From Account Where Id IN: listOfAccounts];
        listOfAccounts[0].Move_To_Contacts__c = 'FirstName = Tester, LastName = Updated, Email = tester1@updated.com'+'\n'+'FirstName = Temp, LastName = Updated, Email = tester1@updated.com';
        listOfAccounts[0].Move_To_Account__c = listOfAccounts[1].Id;
        update listOfAccounts[0];
        data = [Select Id, Name, Contact_Details__c, (Select Id, FirstName, LastName, Email, Previous_Account__c From Contacts) From Account Where Id IN: listOfAccounts];
        //System.debug('line 131 err 126---------'+data[1].Contacts);
        listOfData = new List<String>();
        for(Contact con: data[1].Contacts) {
            listOfData.add('FirstName = '+con.FirstName+', LastName = '+con.LastName+', Email = '+con.Email);
        }
        System.assert(listOfData.contains('FirstName = Tester, LastName = Updated, Email = tester1@updated.com'));
        System.assert(listOfData.contains('FirstName = Temp, LastName = Updated, Email = tester1@updated.com'));
        
        listOfAccounts[0].Move_To_Account__c = listOfAccounts[2].Id;
        update listOfAccounts[0];
        data = [Select Id, Name, Contact_Details__c, (Select Id, FirstName, LastName, Email, Previous_Account__c From Contacts) From Account Where Id IN: listOfAccounts];
        listOfData = new List<String>();
        for(Contact con: data[2].Contacts) {
            listOfData.add('FirstName = '+con.FirstName+', LastName = '+con.LastName+', Email = '+con.Email);
        }
        System.assert(listOfData.contains('FirstName = Tester, LastName = Updated, Email = tester1@updated.com'));
        System.assert(listOfData.contains('FirstName = Temp, LastName = Updated, Email = tester1@updated.com'));
        
        
        listOfAccounts[0].Move_To_Contacts__c = 'FirstName = Temp, LastName = Updated, Email = tester1@updated.com';
        update listOfAccounts;
        data = [Select Id, Name, Contact_Details__c, (Select Id, FirstName, LastName, Email, Previous_Account__c From Contacts) From Account Where Id IN: listOfAccounts];
        for(Account acct1: data) {
            for(Contact con: acct1.Contacts) {
                System.debug('Current data' + con);       
            }
        }
        listOfData = new List<String>();
        for(Contact con: data[2].Contacts) {
            listOfData.add('FirstName = '+con.FirstName+', LastName = '+con.LastName+', Email = '+con.Email);
        }
        System.assert(listOfData.contains('FirstName = Temp, LastName = Updated, Email = tester1@updated.com'));
        listOfData = new List<String>();
        for(Contact con: data[1].Contacts) {
            listOfData.add('FirstName = '+con.FirstName+', LastName = '+con.LastName+', Email = '+con.Email);
        }
        System.assert(listOfData.contains('FirstName = Tester, LastName = Updated, Email = tester1@updated.com'));
        
        Test.stopTest();
    }
}