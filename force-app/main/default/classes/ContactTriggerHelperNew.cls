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
public class ContactTriggerHelperNew {
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
	public static void updateAccountFieldOnContactTrigger(List<Contact> Contacts, Map<Id, Contact> mapOfOldContacts) {
        //Create a set which hold all unique account ids on which change is happening
        //Set<Id> setOfIds = new Set<Id>();
        Map<Id,Account> mapOfAccounts = new Map<Id,Account>();
        
        
        for(Contact con: Contacts != null ? Contacts : mapOfOldContacts.values()) {
            // Insert and Update
            if (Contacts == null || mapOfOldContacts == null || (mapOfOldContacts != null && (con.AccountId != mapOfOldContacts.get(con.Id).AccountID || con.Status__c != mapOfOldContacts.get(con.Id).Status__c))) {
                mapOfAccounts.put(con.AccountID, new Account(Id = con.AccountID, Total_Active_Contacts__c = 0, Total_In_Active_Contacts__c = 0));
                
                if (mapOfOldContacts != null && (con.AccountId != mapOfOldContacts.get(con.Id).AccountID)) {
                    mapOfAccounts.put(mapOfOldContacts.get(con.Id).AccountID, new Account(Id = mapOfOldContacts.get(con.Id).AccountID, Total_Active_Contacts__c = 0, Total_In_Active_Contacts__c = 0));                        
                }
                
            }
        }
        
        if (mapOfAccounts != null && mapOfAccounts.size()>0) {
            AggregateResult[] listOfAccounts = [SELECT COUNT(Id) totalCount, Status__c conStatus, AccountId FROM Contact WHERE AccountId IN : mapOfAccounts.KeySet() GROUP BY AccountId, Status__c];
            if(listOfAccounts.size()>0) {
                for(AggregateResult aR: listOfAccounts){
               
                    System.debug(aR);
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
            
            //Output to show on debug console
            System.debug(mapOfAccounts);
            
            //Check if there is an account to update
            if(mapOfAccounts.size()>0){
                update mapOfAccounts.values();
            }
        }
    }
}