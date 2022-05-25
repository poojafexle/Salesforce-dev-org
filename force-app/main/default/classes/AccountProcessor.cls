public class AccountProcessor {
    @future(callout=true)
	public static void countContacts(List<Id> listOfIds) {
        List<Account> listOfAccountsData = [Select Id, Name, Number_Of_Contacts__c, (Select Id, FirstName, LastName, Email, Previous_Account__c From Contacts) From Account Where Id IN: listOfIds];
        for(Account acc: listOfAccountsData) {
            acc.Number_Of_Contacts__c = acc.Contacts.size();
        }
        if(listOfAccountsData.size()>0) {
            update listOfAccountsData;
        }
    }
}