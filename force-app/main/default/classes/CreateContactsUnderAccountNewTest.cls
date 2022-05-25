@isTest
private class CreateContactsUnderAccountNewTest {
    @testSetup static void makeData(){
        List<Account> listOfAccount = new List<Account>();
        
        Account acct = new Account(Name='user', Contact_Details__c = 'FirstName = test, LastName = test, Email = test@gmail.com'+'\n'
                                   +'FirstName = test1, LastName = test, Email = test@gmail.com'+'\n'
                                   +'FirstName = test2, LastName = test, Email = test@gmail.com');
        listOfAccount.add(acct);
        //Account acct1 = new Account(Name='userBlank', Contact_Details__c = '');
        //listOfAccount.add(acct1);
        insert listOfAccount;
        
        List<Contact> listofContact= new List<Contact>();
        for(Account acc: listOfAccount) {
            listofContact.add(new Contact(AccountID = acc.ID,FirstName = 'test', LastName = 'test', Email = 'test@gmail.com', Status__c = 'Active'));
            listofContact.add(new Contact(AccountID = acc.ID,FirstName = 'testNew', LastName = 'test', Email = 'test@gmail.com', Status__c = 'In-Active'));
            listofContact.add(new Contact(AccountID = acc.ID,FirstName = 'Oldtest', LastName = 'test', Email = 'test@gmail.com'));
        }
		insert listofContact;
    }
    
    @isTest static void validateContactsUnderAccountNewTest() {
        List<Id> listOfIds = new List<Id>();
        Account[] accounts = [Select Id, Name,Contact_Details__c, (Select Id, FirstName, LastName, Email From Contacts) From Account];
        for(Account acct: accounts) {
            listOfIds.add(acct.Id);
        }
        Test.startTest();
        CreateContactsUnderAccountNew.validateContactsUnderAccountNew(listOfIds);
        Account[] acct = [Select Id, Name,Contact_Details__c, (Select Id, FirstName, LastName, Email From Contacts) From Account];
        for(Account acc: acct) {
            //String strContactDetails = acc.Contact_Details__c;
            //strContactDetails = strContactDetails.replace('%%acc.Contact_Details__c%%', (String)acc.Contact_Details__c);
            String str = '';
        	if (acc.Contacts.size() > 0) {
            	for (Contact con: acc.Contacts) {
                	str += 'FirstName = ' +con.FirstName + ', LastName = ' +con.LastName + ', Email = ' +con.Email + '\n';
                	//acct.Contact_Details__c += 'FirstName = ' +con.FirstName + ', LastName = ' +con.LastName + ', Email = ' +con.Email + '\n';
            	}
                if(String.isNotBlank(acc.Contact_Details__c) && acc.Contact_Details__c!=null) {
                	System.assertEquals(str.trim(), acc.Contact_Details__c.trim());
                	//System.assertEquals(acc.Contacts.size(), acc.Contact_Details__c.split('\n').size());
            	}
        	}
        }
        Test.stopTest();
    }
}