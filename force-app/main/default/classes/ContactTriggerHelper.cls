/**
 *  Description     :  Check the value of status of contact and update active contact field accordingly. 						
 *
 *  Created By      :  Pooja Hemrajani
 *
 *  Created Date    :  07-03-2022
 *
 *  Revision Logs   :  V1.0 - Created - Pooja Hemrajani
 *
 **/
public class ContactTriggerHelper {
    /**
    *   
    *   @description    :   Check the value of status of contact and update active contact field accordingly.
    *
    *   @args           :   List<Contact> Contacts, Map<Id, Contact> mapOfOldContacts, Boolean isTriggerDelete
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.0 - Created  - 07-03-2022 - Pooja Hemrajani
    * 
    **/
	public static void updateAccountField(List<Contact> Contacts, Map<Id, Contact> mapOfOldContacts) {
        //Create a set which hold all unique account ids on which change is happening
        Map<Id,Account> mapOfAccounts = new Map<Id,Account>();
        
        for(Contact con: Contacts != null ? Contacts : mapOfOldContacts.values()) {
            // Insert, Update, Undelete and Delete
            if (con.AccountID != null && (Contacts == null || mapOfOldContacts == null || (mapOfOldContacts != null && (con.AccountId != mapOfOldContacts.get(con.Id).AccountID || con.Status__c != mapOfOldContacts.get(con.Id).Status__c)))) {
                mapOfAccounts.put(con.AccountID, new Account(Id = con.AccountID, Total_Active_Contacts__c = 0, Total_In_Active_Contacts__c = 0));
                
                
                // If account name is updated
                if (mapOfOldContacts != null && (con.AccountId != mapOfOldContacts.get(con.Id).AccountID)) {
                    if(mapOfOldContacts.get(con.Id).AccountID != null && String.isNotBlank(mapOfOldContacts.get(con.Id).AccountID)) {
                        mapOfAccounts.put(mapOfOldContacts.get(con.Id).AccountID, new Account(Id = mapOfOldContacts.get(con.Id).AccountID, Total_Active_Contacts__c = 0, Total_In_Active_Contacts__c = 0));                        
                    }
                }
                
            }
        }
        
        //check if there any account in map or not
        if (mapOfAccounts != null && mapOfAccounts.size()>0) {
            //Query for data
            AggregateResult[] listOfAccounts = [SELECT COUNT(Id) totalCount, Status__c conStatus, AccountId FROM Contact WHERE AccountId IN : mapOfAccounts.KeySet() GROUP BY AccountId, Status__c];
            if(listOfAccounts.size()>0) {
                //Loop over data
                for(AggregateResult aR: listOfAccounts){
               
                    Id accId = (Id) aR.get('AccountId');
                    String contactStatus = String.valueof(aR.get('conStatus'));
                    Integer conCount = Integer.valueof(aR.get('totalCount'));
      
                    
                    if(contactStatus == 'Active'){
                        mapOfAccounts.get(accId).Total_Active_Contacts__c = conCount;
                    }
                    
                    if(contactStatus == 'In Active'){
                        mapOfAccounts.get(accId).Total_In_Active_Contacts__c = conCount;
                    }
                    
                }
            }
            
            
            //Check if there is an account to update
            if(mapOfAccounts.size()>0){
                update mapOfAccounts.values();
            }
        }
    }
}