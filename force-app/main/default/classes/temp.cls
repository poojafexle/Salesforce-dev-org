public class temp {
	public static void aggregateSOQLList(){

            //list of accounts
            List<Account> accounts = [SELECT Id, Name FROM Account];
            
            //Map of Account to update the Total Active and Total Inactive Contacts
            Map<Id,Account> mapOfAccounts = new Map<Id,Account>();
        	List<Account> listOfAccounts = new List<Account>();    
        
            //Check list of account is not empty
            if(accounts!= null && accounts.size()>0){
            
                //SOQL to check status of related contacts of account is active or inactive
                for(AggregateResult aR: [SELECT COUNT(Id) totalCount, Status__c conStatus, AccountId FROM Contact WHERE AccountId IN : accounts GROUP BY AccountId, Status__c]){
         		                 
                    Id accId = (Id) aR.get('AccountId');
                    String contactStatus = String.valueof(aR.get('conStatus'));
                    Integer conCount = Integer.valueof(aR.get('totalCount'));
                    Integer counter = 0;
                
                    for (Account acc: listOfAccounts) {
                        if (accId != acc.Id) {
                            counter += 1;
                        }
                    }
                    if (counter == listOfAccounts.size()) {
                        listOfAccounts.add(new Account(Id = accId, Total_Active_Contacts__c = 0, Total_In_Active_Contacts__c = 0));
                    }
                    //if(!mapOfAccounts.containsKey(accId)){
                        //mapOfAccounts.put(accId, new Account(Id = accId, Total_Active_Contacts__c = 0, Total_In_Active_Contacts__c = 0));
                    //}
                
                    if(contactStatus == 'Active'){
                        for (Account acc: listOfAccounts) {
                        	if (accId == acc.Id) {
                                acc.Total_Active_Contacts__c = conCount;
                            }
                        }
                        //mapOfAccounts.get(accId).Total_Active_Contacts__c = conCount;
                    }
                
                    if(contactStatus == 'In-Active'){
                        for (Account acc: listOfAccounts) {
                        	if (accId == acc.Id) {
                                acc.Total_In_Active_Contacts__c = conCount;
                            }
                        }
                        //mapOfAccounts.get(accId).Total_In_Active_Contacts__c = conCount;
                    }
                
                }
           
        		//Output to show on debug console
        		//System.debug(mapOfAccounts);
                System.debug(listOfAccounts);
        
        		//Check if there is an account to update
        		if(mapOfAccounts.size()>0){
            		//update mapOfAccounts.values();
            		update listOfAccounts;
				}
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
     *   @revision Log   :   V1.0 - Created  - 15-02-2022 - Pooja Hemrajani
     * 
     **/
    public static void aggregateSOQL() {
        Account[] acct = [Select Id, Name, Total_Active_Contacts__c, Total_In_Active_Contacts__c, (Select Status__c From Contacts) From Account];
        for (Account acc: acct) {
            Integer active_counter = 0;
            Integer in_active_counter = 0;
            for(Contact con: acc.Contacts) {
                if (con.Status__c == 'Active') {
                    active_counter += 1;
                }
                else if (con.Status__c == 'In Active') {
                    in_active_counter += 1;
                }
            }
            acc.Total_Active_Contacts__c = active_counter;
            acc.Total_In_Active_Contacts__c = in_active_counter;
        }
        update acct;
    }
}