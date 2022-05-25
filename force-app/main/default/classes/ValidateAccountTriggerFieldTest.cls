@isTest
private class ValidateAccountTriggerFieldTest {
	@testSetup static void makeData() {
    }
    
    @isTest static void ValidateAccountFieldTestFunction() {
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
        //Account[] acc = [Select Name, Active__c, In_Active_Reason__c, Rating, AccountNumber From Account];
     
    }
}