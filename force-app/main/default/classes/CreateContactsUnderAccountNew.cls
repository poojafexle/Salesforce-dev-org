/**
 *  Description     :  To create contacts under account using contact detail field.
 *
 *  Created By      :  Pooja Hemrajani
 *
 *  Created Date    :  10-02-2022
 *
 *  Revision Logs   :  V1.0 - Created - 21-02-2022 - Pooja Hemrajani
 *
 **/
public class CreateContactsUnderAccountNew {
    /**
     *   
     *   @description    :   Validating Contacts according to Contact details field.
     *
     *   @args           :   none
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 21-02-2022 - Pooja Hemrajani
     * 
     **/
    public static void validateContactsUnderAccountNew(List<ID> listOfIds) {
        //Fetching detail according to id or list of ids
        Account[] acct = [Select Id, Name, Contact_Details__c, (Select Id, FirstName, LastName, Email From Contacts) From Account Where Id IN: listOfIds];
        List<Contact> listOfContactsToBeUpdated = new List<Contact>();	
        List<Contact> listOfContactsToBeDeleted = new List<Contact>();	
        if (Acct.size() > 0) {
        	for (Account acc: acct) {
                System.debug(acc.Contact_Details__c);
                Map<String, Contact> mapOfStringAndContact = new Map<String, Contact>();
	        	Map<String, Contact> mapOfExistingStringAndContact = new Map<String, Contact>();
                
                //Creating map of contacts that exists under that account
                for(Contact existingCon: acc.Contacts) {
                    String emailStr = existingCon.Email;
                    mapOfExistingStringAndContact.put((existingCon.FirstName+','+emailStr+','+existingCon.LastName), existingCon);
                }
                
                //Creating map of contacts that are written in contact details
                if(String.isNotBlank(acc.Contact_Details__c) && acc.Contact_Details__c!=null) {
                	String[] part = acc.Contact_Details__c.split('\n');
                    //System.debug(part);
                	for(String str: part) {
                    	String[] strPart = str.split(',');
                        //System.debug(strPart);
                    	List<String> listOfStringCon = new List<String>();
                    	for(String strtemp: strPart) {
                        	String str1 = strtemp;
                        	String[] str1Part = str1.split(' = ');
                    		for(String strt: str1Part) {
                            	listOfStringCon.add(strt);
                        	}
                        	//System.debug('listOfStringCon --- ' + listOfStringCon);
                    	}
                    	String emailStr = listOfStringCon[5];
                    	mapOfStringAndContact.put((listOfStringCon[1]+','+emailStr+','+listOfStringCon[3]),new Contact(FirstName = listOfStringCon[1], LastName = listOfStringCon[3]));
                	}   
                }
                
                System.debug(mapOfStringAndContact);
                System.debug(mapOfExistingStringAndContact);
                
                //checks for insertions
                if(String.isNotBlank(acc.Contact_Details__c) && acc.Contact_Details__c!=null) {
                	for (String checkStr: mapOfStringAndContact.KeySet()) {
                    	//System.debug(checkStr.trim());
                    	if (!mapOfExistingStringAndContact.containsKey(checkStr.trim())) {
                      		String[] strPart = checkStr.split(',');
                        	//System.debug(strPart);
                        	listOfContactsToBeUpdated.add(new Contact(FirstName = strPart[0], LastName = strPart[2], Email = strPart[1], AccountId = acc.Id));
                    	}
                	}
                }
                
                //checks for deletion
                if(String.isNotBlank(acc.Contact_Details__c) && acc.Contact_Details__c!=null) {
                	for (String checkStr: mapOfExistingStringAndContact.KeySet()) {
                    	if (!mapOfStringAndContact.containsKey(checkStr.trim())) {
                        	//System.debug(mapOfStringAndContact.containsKey(checkStr.trim()));
                        	listOfContactsToBeDeleted.add(mapOfExistingStringAndContact.get(checkStr.trim()));
                        	//System.debug(checkStr.trim());
                    	}
                	}
                }
                
                //System.debug('listOfContactsToBeUpdated 11 -- '+ listOfContactsToBeUpdated);
                //System.debug('listOfContactsToBeDeleted 11 -- '+ listOfContactsToBeDeleted);
            }
            if(listOfContactsToBeUpdated.size()>0) {
                System.debug('listOfContactsToBeUpdated 11 -- '+ listOfContactsToBeUpdated);
                insert listOfContactsToBeUpdated;   
            }	
            if(listOfContactsToBeDeleted.size()>0) {
                System.debug('listOfContactsToBeDeleted 11 -- '+ listOfContactsToBeDeleted);
                delete listOfContactsToBeDeleted;   
            }
        }
    }
}