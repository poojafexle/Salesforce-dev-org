/**
 *  Description     :  This class have one methods that will extract data from Salesforce Objects using Salesforce Object Query Language.
 *
 *  Created By      :  Pooja Hemrajani
 *
 *  Created Date    :  10-02-2022
 *
 *  Revision Logs   :  V1.0 - Created - 10-02-2022 - Pooja Hemrajani
 * 					   V1.1 - Created - 15-02-2022 - Pooja Hemrajani - Added function of inline and aggregate soql
 *
 **/
public class SOQLQueryClass {
    /**
     *   
     *   @description    :   This method will extract some account recods with conditions and update a field in Salesforce Object.
     *
     *   @args           :   none
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 10-02-2022 - Pooja Hemrajani
     * 
     **/
    public static void normalSOQL() {
        //Getting account records where (Name is not Test OR Name does not contain Fexle) AND Website is not null  
        Account[] acct = [SELECT Id, Name, Website FROM Account WHERE ((NOT(Name LIKE '%Fexle%')) OR Name != 'Test') AND Website != null LIMIT 10];
    	//System.debug(acct);
        
        
        //Looping over account record to get list of contacts with above accounts as there parents
        List<Contact> conn = new List<Contact>();
        if (acct.size() > 0) {
        	conn = [SELECT Id, Account.Website, AccountId, Name, Email FROM Contact WHERE AccountId IN :acct];
	        //System.debug(conn);
        }
        
        //Creating a list for updated contacted list
        List<Contact> updatedContactList = new List<Contact>();
        
        //Looping a nd updating website name
        for (Contact conObj: conn) {
            conObj.Account_Website__c = conObj.Account.Website;
            updatedContactList.add(conObj);
        }
        
        if (updatedContactList.size()>0) {
            //System.debug(updatedContactList);
        	update updatedContactList;
        }
    }
    
    /**
     *   
     *   @description    :   Create and update contact detail field of account records with the values of related contacts.
     *
     *   @args           :   List<Id>
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 15-02-2022 - Pooja Hemrajani
     * 
     **/
    public static void inlineSOQLFunction(List<Id> listOfIds) {
        //Get details of contacts related to account
        Account[] acct = [Select Id, Name, Contact_Details__c, (Select Id, FirstName, LastName, Email From Contacts) From Account Where Id IN :listOfIds Limit 10];
        //Check if there are records in acct
        if (Acct.size() > 0) {
            //Iterate over acct
        	for (Account acc: acct) {
            	//String str = '';
                acc.Contact_Details__c = '';
                if (acc.Contacts.size() > 0) {
            		for (Contact con: acc.Contacts) {
                        //str += 'FirstName = ' +con.FirstName + ', LastName = ' +con.LastName + ', Email = ' +con.Email + '\n';
                        acc.Contact_Details__c += 'FirstName = ' +con.FirstName + ', LastName = ' +con.LastName + ', Email = ' +con.Email + '\n';
            		}
            		//acc.Contact_Details__c = str;
                }
        	}
        }
        if(acct.size()>0){
            update acct;   
        }
    }
    
    
    /**
     *   
     *   @description    :   This method will extract some account recods with conditions and update a field in Salesforce Object.
     *
     *   @args           :   none
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 16-02-2022 - Pooja Hemrajani
     * 
     **/
    public static void aggregateSOQL() {
        List<Account> listOfAccounts = [SELECT Id, Name FROM Account];
        Map<Id,Account> mapOfAccounts = new Map<Id,Account>();
        if(listOfAccounts!= null && listOfAccounts.size()>0){
            
                //SOQL to check status of related contacts of account is active or inactive
                for(AggregateResult aR: [SELECT COUNT(Id) totalCount, Status__c conStatus, AccountId FROM Contact WHERE AccountId IN : listOfAccounts GROUP BY AccountId, Status__c]){
         		                 
                    Id accId = (Id) aR.get('AccountId');
                    String contactStatus = String.valueof(aR.get('conStatus'));
                    Integer conCount = Integer.valueof(aR.get('totalCount'));
            
                    if(!mapOfAccounts.containsKey(accId)){
                        mapOfAccounts.put(accId, new Account(Id = accId, Total_Active_Contacts__c = 0, Total_In_Active_Contacts__c = 0));
                    }
                
                    if(contactStatus == 'Active'){
                        mapOfAccounts.get(accId).Total_Active_Contacts__c = conCount;
                    }
                
                    if(contactStatus == 'In-Active'){
                        mapOfAccounts.get(accId).Total_In_Active_Contacts__c = conCount;
                    }
                
                }
           
        		//Output to show on debug console
        		System.debug(mapOfAccounts);
        
        		//Check if there is an account to update
        		if(mapOfAccounts.size()>0){
            		update mapOfAccounts.values();
				}
        	}
    }
}