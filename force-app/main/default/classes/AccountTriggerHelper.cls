/**
 *  Description     :   1. Update account number onchange of rating
 * 						2. Check the value of active picklist on account and update add error on in active reason account field accordingly. 						
 *
 *  Created By      :  Pooja Hemrajani
 *
 *  Created Date    :  07-03-2022
 *
 *  Revision Logs   :  V1.0 - Created - Pooja Hemrajani
 *
 **/
public class AccountTriggerHelper {
    
    /**
    *   
    *   @description    :   This method will update account number onchange of rating.
    *
    *   @args           :   List<Account> accounts, Map<Id, Account> mapOldAccounts
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.0 - Created  - 01-03-2022 - Pooja Hemrajani
    * 
    **/
    
    public static void setAccountRating(List<Account> accounts, Map<Id, Account> mapOldAccounts) {
     
        if (accounts != null && accounts.size()>0) { 
            for(Account acc: accounts) {
                //Check for insert, update and will enter only if rating is updated
                if (mapOldAccounts == null || (mapOldAccounts != null && acc.rating != mapOldAccounts.get(acc.Id).rating)) {
                    if(acc.rating == 'Cold') {
                        acc.AccountNumber = '1234';
                    }
                    else if(acc.rating == 'Hot') {
                        acc.AccountNumber = '1';                
                    }
                    else if(acc.rating != 'Warm') {
                        acc.AccountNumber = '0';
                    }
                }
            }
        }
        
    }
    
    
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
    public static void ValidateAccountField(List<Account> listOfAccounts, Map<Id, Account> mapOldAccounts) {
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
    
    /**
    *   
    *   @description    :   Create and delete contacts according to Contact Details and Contact Details 1,
    * 						Populate contact according to data provided written in move to contact and move to account.
    *
    *   @args           :   List<Account> listOfAccounts, Map<Id, Account> mapOldAccounts
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.0 - Created  - 09-03-2022 - Pooja Hemrajani
    * 
    **/
    
    public static void moveContactUnderGivenAccount(List<Account> listOfAccounts, Map<Id, Account> mapOldAccounts) {
       	//Arranging data
        Set<Id> setOfIds = new Set<Id>();
        for(account acc: listOfAccounts) {
            setOfIds.add(acc.Id);
            setOfIds.add(acc.Move_To_Account__c);
        }
        if (mapOldAccounts != null && mapOldAccounts.KeySet().size()>0){
        	for(account acc: mapOldAccounts.Values()) {
                //setOfIds.add(acc.Id);
                setOfIds.add(acc.Move_To_Account__c);
            }    
        }
        List<Id> listOfIds = new List<Id>();
        if(setOfIds.size()>0) {
            for(Id counterId: setOfIds) {
                listOfIds.add(counterId);
            }
        }
        Account[] acct;
        if(listOfIds.size()>0) {
            acct = [Select Id, Name, Contact_Details__c, (Select Id, FirstName, LastName, Email, Previous_Account__c From Contacts) From Account Where Id IN: listOfIds];
        }
        Map<Id, List<Contact>> mapOfIdAndContacts = new Map<Id, List<Contact>>();
        if(acct.size()>0) {
            for(Account acc: acct) {
                mapOfIdAndContacts.put(acc.Id, acc.Contacts);
            }
        }
        //Data done
        
        //Logic Part
        
        //Essential entities
        List<Contact> listOfContactsToBeUpdated = new List<Contact>();
        List<Contact> listOfContactsToBeInserted = new List<Contact>();
        Map<Id, List<String>> mapOfData = new Map<Id, List<String>>();
        
        //Loop over data
        for(Account acc: listOfAccounts) {
            
            //Checking and validating data for Contacts in ContactDetails & ContactDetails1
            if(acc.Contact_Details__c != null || acc.Contact_Details_1__c != null) {
                if (mapOldAccounts == null || (mapOldAccounts != null && (acc.Contact_Details__c+acc.Contact_Details_1__c != mapOldAccounts.get(acc.Id).Contact_Details__c+mapOldAccounts.get(acc.Id).Contact_Details_1__c))) {
                    String[] ContactDetails = acc.Contact_Details__c!=null ? acc.Contact_Details__c.split('\n') : null;
                    String[] ContactDetailsNew = acc.Contact_Details_1__c!=null ? acc.Contact_Details_1__c.split('\n') : null;
                    List<String> listOfString = new List<String>();
                    if(ContactDetails!=null) {
                        for (String str: ContactDetails) {
                            listOfString.add(str.trim());
                    	}
                    }
                    if(ContactDetailsNew!=null) {
                        for (String str1: ContactDetailsNew) {
                            if (!listOfString.contains(str1.trim())) {
                                listOfString.add(str1.trim());   
                            }
                        }
                    }
                    mapOfData.put(acc.Id, listOfString);
                }
            }
            
            //Validating data according to Move to Account and Move to Contact field
            if (mapOldAccounts == null || (mapOldAccounts != null && (acc.Move_To_Account__c != mapOldAccounts.get(acc.Id).Move_To_Account__c || acc.Move_To_Contacts__c !=mapOldAccounts.get(acc.Id).Move_To_Contacts__c))) {
                if(acc.Move_To_Account__c != null) {
                    Map <Id, List<Contact>> mapOfMoveToContacts = new Map<Id, List<Contact>>();
                    if(acc.Move_To_Contacts__c != null) {
                        String[] strPart = acc.Move_To_Contacts__c.split('\n');
                        List<Contact> listOfMoveToContact = new List<Contact>();
                        for(String str1: strPart) {
                            String[] str1Part = str1.trim().split(',');
                            List<String> listOfStringCon = new List<String>();
                            for(String strtemp: str1Part) {
                                String str = strtemp;
                                String[] strP = str.split(' = ');
                                for(String strt: strP) {
                                    listOfStringCon.add(strt);
                                }
                            }
                            listOfMoveToContact.add(new Contact(FirstName = listOfStringCon[1],LastName = listOfStringCon[3], email = listOfStringCon[5]));
                        }
                        mapOfMoveToContacts.put(acc.ID, listOfMoveToContact);
                    }
                    Contact[] updatedData;
                    ID counterId;
                    if(acc.Move_To_Account__c != mapOldAccounts.get(acc.Id).Move_To_Account__c && acc.Move_To_Contacts__c != mapOldAccounts.get(acc.Id).Move_To_Contacts__c) {
                        updatedData = mapOfIdAndContacts.get(acc.Id);
                    }
                    if(acc.Move_To_Account__c != mapOldAccounts.get(acc.Id).Move_To_Account__c && acc.Move_To_Contacts__c == mapOldAccounts.get(acc.Id).Move_To_Contacts__c) {
                        counterId = mapOldAccounts.get(acc.Id).Move_To_Account__c;
                        updatedData = mapOfIdAndContacts.get(counterID != null ? counterId : acc.ID);
                    }
                    if(acc.Move_To_Account__c == mapOldAccounts.get(acc.Id).Move_To_Account__c && acc.Move_To_Contacts__c != mapOldAccounts.get(acc.Id).Move_To_Contacts__c) {
                        updatedData = mapOfIdAndContacts.get(acc.Id);
                        Map <Id, List<Contact>> mapOfMoveToContactsOld = new Map<Id, List<Contact>>();
                        if(mapOldAccounts.get(acc.Id).Move_To_Contacts__c != null) {
                            String[] strPartOld = mapOldAccounts.get(acc.Id).Move_To_Contacts__c.split('\n');
                            List<Contact> listOfMoveToContactOld = new List<Contact>();
                            for(String str1Old: strPartOld) {
                                String[] str1PartOld = str1Old.trim().split(',');
                                List<String> listOfStringConOld = new List<String>();
                                for(String strtempOld: str1PartOld) {
                                    String strOld = strtempOld;
                                    String[] strPOld = strOld.split(' = ');
                                    for(String strtOld: strPOld) {
                                        listOfStringConOld.add(strtOld);
                                    }
                                }
                                listOfMoveToContactOld.add(new Contact(FirstName = listOfStringConOld[1],LastName = listOfStringConOld[3], email = listOfStringConOld[5]));
                            }
                            mapOfMoveToContactsOld.put(acc.ID, listOfMoveToContactOld);
                            for(Contact conn: mapOfMoveToContactsOld.get(acc.Id)) {
                                if(mapOfMoveToContacts.KeySet().size()==0 || mapOfMoveToContacts.KeySet().size()>0 && (!mapOfMoveToContacts.get(acc.Id).contains(conn))) {
                                    for(Contact con: mapOfIdAndContacts.get(mapOldAccounts.get(acc.Id).Move_To_Account__c)) {
                                        if(conn.FirstName == con.FirstName && conn.LastName == con.LastName && conn.Email == con.Email) {
                                            if(con.Previous_Account__c != null) {
                                                listOfContactsToBeUpdated.add(new Contact(Id=con.ID , AccountId=con.Previous_Account__c, Previous_Account__c = acc.Move_To_Account__c));
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    if(acc.Move_To_Contacts__c != null) {
                        for(Contact conn: mapOfMoveToContacts.get(acc.Id)) {
                            Integer counter = 0;
                            for(Contact con: updatedData) {
                                if(con.FirstName == conn.FirstName && con.LastName == conn.LastName && con.Email == conn.Email) {
                                    listOfContactsToBeUpdated.add(new Contact(Id=con.ID , AccountId=acc.Move_To_Account__c, Previous_Account__c = (counterId!=null ? counterId : acc.Id)));
                                } else {
                                    counter++;
                                }
                            }
                            if(counter == updatedData.size()) {
                                listOfContactsToBeInserted.add(new Contact(FirstName = conn.FirstName,LastName = conn.LastName, email = conn.Email, AccountId=acc.Move_To_Account__c));
                            }
                        }
                    }
                }
            }
        }
        
        //Method Calling
        if(mapOfData != null) {
            //System.debug(mapOfData);
            CreateContactsUnderAccount.validateContactsUnderAccountNew(mapOfData);
        }
        
        //Selective insertions
        if(listOfContactsToBeUpdated.size()>0) {
            update listOfContactsToBeUpdated;
        } 
        if(listOfContactsToBeInserted.size()>0) {
            List<Contact> listOfContactsToBeInsertedFinal = new List<Contact>();
            for(Contact con: listOfContactsToBeInserted) {
                Integer counter = 0;
                for(Contact conn: mapOfIdAndContacts.get(con.AccountId)) {
                    if(con.FirstName != conn.FirstName || con.LastName != conn.LastName || con.Email != conn.Email) {
                        counter++;
                    }
                }
                if(counter == mapOfIdAndContacts.get(con.AccountId).size()) {
                    listOfContactsToBeInsertedFinal.add(con);
                }
            }
            if(listOfContactsToBeInsertedFinal.size()>0) {
                insert listOfContactsToBeInsertedFinal;
            }
        }
    }

}