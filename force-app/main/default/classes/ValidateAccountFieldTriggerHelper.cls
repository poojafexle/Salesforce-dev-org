/**
 *  Description     :  Check the value of active picklist pf account and update add error on in active reason contact field accordingly. 						
 *
 *  Created By      :  Pooja Hemrajani
 *
 *  Created Date    :  07-03-2022
 *
 *  Revision Logs   :  V1.0 - Created - Pooja Hemrajani
 *
 **/
public class ValidateAccountFieldTriggerHelper {
    
    
    
    
    /**
    *   
    *   @description    :   Check the value of status of contact and update active contact field accordingly.
    *
    *   @args           :   List<Account> listOfAccounts, Map<Id, Account> mapOldAccounts
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.0 - Created  - 07-03-2022 - Pooja Hemrajani
    * 
    **/
    public static void ValidateAccountFieldFunction(List<Account> listOfAccounts, Map<Id, Account> mapOldAccounts) {
        //Check for list of account
        if (listOfAccounts.size() > 0) {
            
            //Loop on accounts
            for(Account acc: listOfAccounts) {
                
                //Condition for insert and update
                if(mapOldAccounts == null || (mapOldAccounts != null && (acc.Active__c != mapOldAccounts.get(acc.Id).Active__c || acc.In_Active_Reason__c != mapOldAccounts.get(acc.Id).In_Active_Reason__c))) {
                    
                    //If active is false
                    if(acc.Active__c == 'No') {
                        
                        //If no reason on in active
                        if (String.isBlank(acc.In_Active_Reason__c))
                            acc.In_Active_Reason__c.addError('Please select In Active Reason for the Account.');
                    }
                }
            }
        }
    }
}