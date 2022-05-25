/**
*  Description     :  Create/Delete the contacts under the Account according to the value in the Contact Details field.
*
*  Created By      :  Rajveer Singh Rawat
*
*  Created Date    :  16 Feb 2022
*
*  Revision Logs   :  V1.0 - Created - Rajveer Singh Rawat
*				      
*
**/
public class Rajveer {
    /**
*  Description     :  Create/Delete the contacts under the Account according to the value in the Contact Details field.
*
*  @args           :  List<Id>
*
*  @return         :  Void
*
*  Revision Logs   :  V1.0 - Created - 16 feb 2022 - Rajveer Singh Rawat
*
**/ 
    public static void validateContactsUnderAccountMethodSecond(List<Id> accId){
        
        // List of Acccount and contact on particular account Id
        List<Account> listOfAccount = [Select Name, Contact_Details__c , (Select Account.Name, FirstName, LastName, Email From Contacts) From Account Where Id IN : accId];
        // Map of (AccountId,(String,Contact))
        Map<Id, Map<String,Contact>> mapOfIdStringContact = new Map<Id, Map<String,Contact>>();
        // this list Store the contact who will go for the insertion
        List<Contact> listOfInsertingContact = new List<Contact>();
        //this list store the deletd data
        List<Contact> listOfDeletedContact = new List<Contact>();
        
        // Filling map data from listOfAccount SOQL to  
        for(Account acc : listOfAccount){ 
            //Inner Map of mapOfIdStringContact Map of (String,Contact)
            Map<String,Contact> mapOfStringContact = new Map<String,Contact>();
            for(Contact con : acc.Contacts){
                String validateData = 'FirstName = '+ con.FirstName +', LastName = ' +con.LastName +', Email = '+ con.Email; 
                mapOfStringContact.put(validateData,con); 
            }
            mapOfIdStringContact.put(acc.Id,mapOfStringContact); 
        }
        //System.debug('---------------->>>> Before'+ mapOfIdStringContact.get('0015g00000fDxTMAA0').keySet());
        // validate contactDetails field to mapOfIdStringContact
        for(Account acc : listOfAccount){
            for(String contactDetails : acc.contact_Details__c.split('\n')){ 
                    System.debug(mapOfIdStringContact.get(acc.Id).containsKey(contactDetails.trim()));
                    if(mapOfIdStringContact.get(acc.Id).containsKey(contactDetails.trim())){
                        system.debug('remove--- '+contactDetails.trim());
                        mapOfIdStringContact.get(acc.Id).remove(contactDetails.trim()); 
                    }
                    else{
                        //splitting the value from individual substring
                        String fName = contactDetails.substringBetween('FirstName =',',');
                        String LName = contactDetails.substringBetween('LastName =',',');
                        String fieldEmail = contactDetails.substringAfterLast('=');
                        listOfInsertingContact.add(new Contact(AccountId=acc.Id,FirstName=fName.trim(),LastName=lname.trim(),Email=fieldEmail.trim()));
                    }
                }
             
        }
        
        // Here we will store the remaining mapOfIdStringContact data in listOfDeletedContact for insert
        for(Account accObj : listOfAccount){
                for(String str : mapOfIdStringContact.get(accObj.Id).keySet()){
                    listOfDeletedContact.add(mapOfIdStringContact.get(accObj.Id).get(str));
                    //System.debug('!!!!!!!!!!!!!'+mapOfIdStringContact.get(accObj.Id).get(str));
                }
            
        }
        
        //delete remaining contact which is not match on contact details contact
        if(listOfDeletedContact.size() > 0){
            System.debug('listOfDeletedContact'+listOfDeletedContact);
            delete listOfDeletedContact; 
        }
        
        // Insert data which is new on contact details
        if(listOfInsertingContact.size() > 0){
            System.debug('listOfInsertingContact'+listOfInsertingContact);
            insert listOfInsertingContact; 
        }
    }
}