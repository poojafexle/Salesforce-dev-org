public class testerContactTrigger {
	public static void ContactTriggerHelperFunc(List<Contact> Contacts) {
        //Set<Id> setOfIds = new Set<Id>();
        //Map<Id, Integer> mapOfaccount = new Map<Id, Integer>();
        List<Account> listOfAccount = new List<Account>();
        System.debug('Yes');
        for(Contact con: Contacts) {
            if (con.Status__c == 'Active') {
                Account a = new Account();
                a.Id = con.AccountId;
                System.debug('a.Id---' + a.Id);
                if (a.Total_Active_Contacts__c != null) {
                    a.Total_Active_Contacts__c += 1;                    
                } else{
                    a.Total_Active_Contacts__c = 1;
                }
                System.debug(a.Total_Active_Contacts__c);
                listOfAccount.add(a); 
            } else {
                Account a = new Account();
                a.Id = con.AccountId;
                System.debug('a.Id---' + a.Id);
                if (a.Total_In_Active_Contacts__c != null) {
                    a.Total_In_Active_Contacts__c += 1;                    
                } else{
                    a.Total_In_Active_Contacts__c = 1;
                }
                System.debug(a.Total_In_Active_Contacts__c);
                listOfAccount.add(a); 
            }   
        }
    }
}