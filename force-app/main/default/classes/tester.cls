/**
*  Description     :  Account_Trigger Helper class
Here we are performing operation on Account Rating and populate Account Number field ..
*
*  Created By      :  Rajveer Singh Rawat
*
*  Created Date    :  1 March 2022
*
*  Revision Logs   :  V1.0 - Created - Rajveer Singh Rawat
*				      
*
**/
public class tester {
    
/**
*  Description     :  It's works on all operation
                      If Account Rating is Cold than set AccountNumber to 1234
                      If Account Rating is HOT than set AccountNumber to 1
                      If Account Rating is blank/null than set AccountNumber to 0
*
*  @args           :  List<Account> , Map<Id,Account>
*
*  @return         :  No
*
*  Revision Logs   :  V1.0 - Created - 9 March 2022 - Rajveer Singh Rawat
*
**/
 public static void allContactDetailsOperation(List<Account> accountData, Map<Id,Account> oldMap){
        // this list Store the contact who will go for the insertion
        List<Contact> listOfInsertingContact = new List<Contact>();
        //this list store the deletd data
        List<Contact> listOfDeletedContact = new List<Contact>();
        // List for store contact details data
        List<String> listOfContactDetails = new List<String>();
        //List for store contact details1 data
        List<String> listOfContactDetails1 = new List<String>();
        // set to store both listOfContactDetails,listOfContactDetails1 value in unique format
        Set<String> setOfContactDetailsAnd1 = new Set<String>();
        List<String> listOfMoveToContact = new List<String>();
        List<Contact> listOfaddMoveContactData = new List<Contact>();
        //Set of Move Account Id
        Set<Id> setOfMoveAccountId = new Set<Id>();
        Set<Id> setOfNewMoveAccountId = new Set<Id>();
        MAp<Id,Id> mapOfMoveAndCurrentId = new Map<Id,Id>();
        Map<String,Contact> mapOfData = new Map<String,Contact>();
        Map<String,Contact> mapOfRemoveData = new Map<String,Contact>();
        //Set of Account Id
        Set<Id> setOfAccountId = new Set<Id>();
        for(Account accId : accountData){
            if(oldMap == null || (oldMap.get(accId.Id).Contact_Details__c != accId.Contact_Details__c) || (oldMap.get(accId.Id).Contact_Details_1__c != accId.Contact_Details_1__c) || (oldMap.get(accId.Id).Move_To_Contacts__c != accId.Move_To_Contacts__c) || (oldMap.get(accId.Id).Move_To_Account__c != accId.Move_To_Account__c) ||  (oldMap.get(accId.Id).Move_To_Contacts__c != accId.Move_To_Contacts__c) && (oldMap.get(accId.Id).Move_To_Account__c != accId.Move_To_Account__c)){
                setOfAccountId.add(accId.Id);
                // setOfMoveAccountId this store old Move_To_Account__c value for update case 
                if(oldMap != null){
                    setOfMoveAccountId.add(oldMap.get(accId.Id).Move_To_Account__c);
                    if((accId.Move_To_Contacts__c != oldMap.get(accId.id).Move_To_Contacts__c)){
                        setOfNewMoveAccountId.add(accId.Move_To_Account__c);
                    }
                }
            }
        }
        // List of Acccount and contact on particular account Id
        List<Contact> listOfContact = [Select Id, FirstName,LastName,Email,Previous_Account__c,Account.Name,AccountId from Contact Where AccountId = :setOfMoveAccountId];
        List<Contact> listOfNewMoveAccount = [Select Id, FirstName,LastName,Email,Previous_Account__c,Account.Name,AccountId from Contact Where AccountId = :setOfNewMoveAccountId ];
        if(setOfAccountId.size() > 0){
            // store current record data..
            List<Account> listOfAccountContacts = [Select Name, Contact_Details__c ,Contact_Details_1__c, Move_To_Contacts__c, Move_To_Account__c, (Select Account.Name,AccountId, FirstName, LastName, Previous_Account__c, Email From Contacts) 
                                                   From Account Where Id IN : setOfAccountId];
            System.debug('Inside');
            // Map of (AccountId,(String,Contact))
            Map<Id, Map<String,Contact>> mapOfIdStringContact = new Map<Id, Map<String,Contact>>();
            // Map of (AccountId,(String,Contact))
            Map<Id, Map<String,Contact>> mapOfIdStringContactValues = new Map<Id, Map<String,Contact>>();
            // Filling map data from listOfAccount SOQL to  
            for(Account acc : listOfAccountContacts){
                if(String.isNotBlank(acc.contact_Details__c)){
                    listOfContactDetails = acc.contact_Details__c.split('\n'); 
                    setOfContactDetailsAnd1.addAll(listOfContactDetails);
                }
                if(String.isNotBlank(acc.Contact_Details_1__c)){
                    listOfContactDetails1 = acc.Contact_Details_1__c.split('\n');
                    setOfContactDetailsAnd1.addAll(listOfContactDetails1);  
                }
                
                
                // Map of (String,Contact)
                    Map<String,Contact> mapOfExistingContact = new Map<String,Contact>();
                    for(Contact con : acc.Contacts){
                        String validateData = 'FirstName = '+ con.FirstName +', LastName = ' +con.LastName +', Email = '+ con.Email;
                        //System.debug(validateData);
                        mapOfExistingContact.put(validateData,con); 
                    }
                    //System.debug('mapOfExistingContact'+mapOfExistingContact.size());
                    mapOfIdStringContact.put(acc.Id,mapOfExistingContact);
                
            }
            // validate contactDetails field to mapOfIdStringContact
            for(Account accObj : listOfAccountContacts){
                for(String contactDetails : setOfContactDetailsAnd1){ 
                    if(mapOfIdStringContact.containsKey(accObj.Id)){
                        if(mapOfIdStringContact.get(accObj.Id).containsKey(contactDetails.trim())){
                            mapOfIdStringContact.get(accObj.Id).remove(contactDetails.trim());
                            //System.debug('contactDetails.trim'+contactDetails.trim());
                        }
                        else{
                            //splitting the value from individual substring
                            String fName = contactDetails.substringBetween('FirstName =',',');
                            String LName = contactDetails.substringBetween('LastName =',',');
                            String fieldEmail = contactDetails.substringAfterLast('=');
                            listOfInsertingContact.add(new Contact(AccountId=accObj.Id,FirstName=fName,LastName=lname,Email=fieldEmail)); 
                        }
                    }
                }
            }
            
            // Here we will store the remaining mapOfIdStringContact data in listOfDeletedContact for insert
            // 1.2: If there is any additional contact under the Account then delete that Only delete if Previous Account field is blank
            if(mapOfIdStringContact.size() > 0){
                for(Account accObj : listOfAccountContacts){
                    for(String str : mapOfIdStringContact.get(accObj.Id).keySet()){
                        if(String.isBlank(mapOfIdStringContact.get(accObj.Id).get(str).Previous_Account__c)){
                            listOfDeletedContact.add(mapOfIdStringContact.get(accObj.Id).get(str.trim()));
                            //System.debug('Delete value'+str.trim());
                        }
                    }
                }
            }
            // for 2.1 
            System.debug('listOfContact***'+listOfContact);
            Map<String,Contact> mapOfContactId = new Map<String,Contact>();
            Map<String,Contact> mapOfExistMoveAccountRecord = new Map<String,Contact>();
            List<Contact> listOfInsertionMoveAccount = new List<Contact>(); 
            
            
            for(Account accountObj : listOfAccountContacts){
                
                // 2.1,2.3 fill existing records map for check move to contact data present or not in current record
                if(((oldMap == null) && (String.isNotBlank(accountObj.Move_To_Contacts__c) && String.isNotBlank(accountObj.Move_To_Account__c))) || ((oldMap!= null) && (accountObj.Move_To_Contacts__c != oldMap.get(accountObj.id).Move_To_Contacts__c)) || (((oldMap!= null) && (accountObj.Move_To_Contacts__c != oldMap.get(accountObj.id).Move_To_Contacts__c)) && (((oldMap!= null) && (accountObj.Move_To_Account__c != oldMap.get(accountObj.id).Move_To_Account__c)))) ){
                    Map<String,Contact> mapOfExistingContact2 = new Map<String,Contact>();
                    for(Contact con : accountObj.Contacts){
                        String validateData2 = 'FirstName = '+ con.FirstName +', LastName = ' +con.LastName +', Email = '+ con.Email;
                        //System.debug(validateData);
                        mapOfExistingContact2.put(validateData2,con); 
                    }
                    mapOfIdStringContactValues.put(accountObj.Id,mapOfExistingContact2);
                    System.debug('mapOfIdStringContactValues'+mapOfIdStringContactValues);
                    // Check record is present or not..
                    for(String moveCon : accountObj.Move_To_Contacts__c.split('\n')){
                        //override same value map
                        if(mapOfIdStringContactValues.get(accountObj.Id).containsKey(moveCon.trim())){
                            System.debug('Inside-2');
                            mapOfIdStringContactValues.get(accountObj.Id).get(moveCon.trim()).Previous_Account__c = accountObj.Id;
                            mapOfIdStringContactValues.get(accountObj.Id).get(moveCon.trim()).AccountId = accountObj.Move_To_Account__c;
                        }
                        else{
                            System.debug('Else moveCon'+moveCon);
                            String fName = moveCon.substringBetween('FirstName =',',');
                            String LName = moveCon.substringBetween('LastName =',',');
                            String fieldEmail = moveCon.substringAfterLast('=');
                            listOfaddMoveContactData.add(new Contact(AccountId=accountObj.Move_To_Account__c,FirstName=fName,LastName=lname,Email=fieldEmail,Previous_Account__c=accountObj.Id));
                        }
                    }
                    // 2.3 remove case
                   
                   if(oldMap!= null){
                        if((accountObj.Move_To_Contacts__c != oldMap.get(accountObj.id).Move_To_Contacts__c) ){
                            if(oldMap.get(accountObj.Id).Move_To_Contacts__c != null){
                            if(listOfContact.size() > 0){
                            for(Contact oldMoveAccountData : listOfContact){
                                String moveToAccData = 'FirstName = '+oldMoveAccountData.FirstName +', LastName = '+oldMoveAccountData.LastName +', Email = '+oldMoveAccountData.Email;
                                mapOfExistMoveAccountRecord.put(moveToAccData.trim(),oldMoveAccountData);
                            }
                            Map<String,String> mapOfString = new Map<String,String>();
                            List<String> listOfPresentMoveToContacts = accountObj.Move_To_Contacts__c.split('\n');
                            List<String> listOfMoveToOldContacts = oldMap.get(accountObj.Id).Move_To_Contacts__c.split('\n');
                                for(String s : listOfPresentMoveToContacts){
                                    String fName = s.substringBetween('FirstName =',',');
                                    String LName = s.substringBetween('LastName =',',');
                                    String fieldEmail = s.substringAfterLast('=');
                                    String moveToConData = 'FirstName = '+fName +', LastName = '+LName +', Email = '+fieldEmail;
                                    mapOfString.put(moveToConData.trim(),moveToConData);
                                }
                                if(listOfMoveToOldContacts.size() > 0){ 
                                    //System.debug('Inside-3');
                                    System.debug('!!!!!!!!!mapOfString'+mapOfString);
                                    for(String oldMoveCon : listOfMoveToOldContacts) { 
                                        if(!mapOfString.containsKey(oldMoveCon.trim()) && mapOfExistMoveAccountRecord.containsKey(oldMoveCon.trim())){ 
                                            System.debug(mapOfExistMoveAccountRecord.get(oldMoveCon.trim()));
                                            System.debug('oldMoveCon'+oldMoveCon);
                                            mapOfExistMoveAccountRecord.get(oldMoveCon.trim()).Previous_Account__c = mapOfExistMoveAccountRecord.get(oldMoveCon.trim()).AccountId;
                                            mapOfExistMoveAccountRecord.get(oldMoveCon.trim()).AccountId = accountObj.Id;
                                        }
                                    }
                                }   
                            } 
                          }
                        }
                   } 
                }   
                System.debug('listOfaddMoveContactData +'+listOfaddMoveContactData);
                // 2.2 if If someone change the Move to Account, then move all the contacts those are mentioned in "Move To Contacts" field from previous Move To Account to new Move TO Account.
                if(oldMap != null){
                    if((oldMap.get(accountObj.Id).Move_To_Account__c != accountObj.Move_To_Account__c)){
                        if(oldMap.get(accountObj.Id).Move_To_Contacts__c != null){
                            List<String> listOfMoveToContacts = oldMap.get(accountObj.Id).Move_To_Contacts__c.split('\n');
                            if(listOfMoveToContacts.size() > 0){ 
                                //System.debug('Inside-3');
                                for(Contact prevAccCont : listOfContact) {
                                    String existData = 'FirstName = '+ prevAccCont.FirstName +', LastName = ' +prevAccCont.LastName +', Email = '+ prevAccCont.Email;
                                    mapOfContactId.put(existData,prevAccCont);
                                }
                                //System.debug('mapOfContactId before'+mapOfContactId);
                                
                                for(String moveToContact : listOfMoveToContacts){
                                    System.debug('moveToContact'+moveToContact);
                                    if(mapOfContactId.containskey(moveToContact.trim())){
                                        String previousAccountId = mapOfContactId.get(moveToContact.trim()).AccountId;
                                        System.debug('&&&&&&'+previousAccountId);
                                        mapOfContactId.get(moveToContact.trim()).Previous_Account__c = previousAccountId;
                                        mapOfContactId.get(moveToContact.trim()).AccountId=accountObj.Move_To_Account__c;
                                        mapOfData.put(moveToContact.trim(),mapOfContactId.get(moveToContact.trim()));
                                    }
                                }
                            }
                        }
                    }
                }
            }
            // List for update matching data from move to Contact..
            List<Contact> listOfUpdatingContact = new List<Contact>();
            //fill list to map for update same contact in move to contact
            if(mapOfIdStringContactValues.size() > 0){
                for(Account accObj : listOfAccountContacts){
                    for(String str : mapOfIdStringContactValues.get(accObj.Id).keySet()){
                        listOfUpdatingContact.add(mapOfIdStringContactValues.get(accObj.Id).get(str.trim()));
                    }
                }
            }
            // Update those move to contact which is present in current account..
            if(listOfUpdatingContact.size() > 0){
                
                System.debug(listOfUpdatingContact);
                update listOfUpdatingContact;
            }
            // for 2.2 if someone change move to account than..
            if(mapOfData.size() > 0){
                update mapOfData.values();
            }
            //Insert data which is not matched in existing contact to move to contact
            if(listOfaddMoveContactData.size() > 0){
                insert listOfaddMoveContactData;
            }
            // for 2.3 remove case
            if(mapOfExistMoveAccountRecord.size() > 0){
                update mapOfExistMoveAccountRecord.values();
            }
        }
            
        // for 1
        if(listOfInsertingContact.size() > 0){
            insert listOfInsertingContact;
        }
        if(listOfDeletedContact.size() > 0){
            delete listOfDeletedContact;
        }
     }

}