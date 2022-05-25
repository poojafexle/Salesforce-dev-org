/**
 *  Description     :  Starting with DML operations.                                                                                  
 *                     
 *  Created By      :  Pooja Hemrajani
 *
 *  Created Date    :  07-02-2022
 *
 *  Revision Logs   :  V1.0 - Created - Pooja Hemrajani
 *
 * 
 **/
public class MyFirstDMLClass {

       /**
     	*   
     	*   @description    :   This method will insert data into database using insert of DML.
     	*
     	*   @args           :   none
     	*
     	*   @return         :   void
     	*
     	*   @revision Log   :   V1.0 - Created  - 07-02-2022 - Pooja Hemrajani
     	* 
     	**/
	    public static void firstDMLMethod() {
    	
    		List<Account> listOfAccounts = new List<Account>();
            Account acct1 = new Account(Name = 'Apple', AccountSource = 'Web');
        	listOfAccounts.add(acct1);
            Account acct2 = new Account(Name = 'Mango', AccountSource = 'Web');
            listOfAccounts.add(acct2);
            Account acct3 = new Account(Name = 'Papaya', AccountSource = 'Web');
            listOfAccounts.add(acct3);
            Account acct4 = new Account(Name = 'Guava', AccountSource = 'Web');
            listOfAccounts.add(acct4);
            Account acct5 = new Account(Name = 'Strawberry', AccountSource = 'Web');
            listOfAccounts.add(acct5);
            insert listOfAccounts;
            
    		List<Contact> listOfContacts = new List<Contact>();
            List<Id> listOfId = new List<Id>{acct1.ID, acct2.ID, acct3.ID, acct4.ID, acct5.ID};
            for (Integer i=0; i<5; i++) {
                for (Integer j=0; j<5; j++) {
                	Contact con = new Contact(FirstName=('Joe' + i + j), LastName='Smith', Phone='415.555.1212',AccountId=listOfId[j]);
                	listOfContacts.add(con);
                }
            }
            insert listOfContacts;
            
		}
    
}